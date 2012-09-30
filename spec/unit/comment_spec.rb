require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Insightly::Comment do
  before(:each) do
    Insightly::Configuration.api_key = INSIGHTLY_API_KEY
    Insightly::Configuration.logger = Insightly::Configuration._debug_logger
    @comment = Insightly::Comment.new.build({
                                                "COMMENT_ID" => 132456,
                                                "BODY" => "test comment",
                                                "OWNER_USER_ID" => 12345,
                                                "DATE_CREATED_UTC" => "2012-03-09 11:59:19",
                                                "DATE_UPDATED_UTC" => "2012-03-09 11:59:19",
                                                "FILE_ATTACHMENTS" =>
                                                    {
                                                        "FILE_ID" => 4567899,
                                                        "FILE_NAME" => "test.docx",
                                                        "CONTENT_TYPE" => "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
                                                        "FILE_SIZE" => 2489,
                                                        "FILE_CATEGORY_ID" => nil,
                                                        "OWNER_USER_ID" => 12345,
                                                        "DATE_CREATED_UTC" => "2012-03-09 11:59:20",
                                                        "DATE_UPDATED_UTC" => "2012-03-09 11:59:20",
                                                        "URL" => "/api/fileattachments/4567899"
                                                    }
                                            }
    )

    # @comment = Insightly::Comment.new(3216775)
  end
  it "should be able to create a comment" do
  end
  it "should have a url base" do
    @comment.url_base.should == "Comments"
  end
  it "should know the comment id" do
    @comment.comment_id.should == 132456
  end
  it "should know that the remote id and the comment id are the same" do
    @comment.remote_id.should == @comment.comment_id
  end
  it "should allow you to load based on an id" do
    VCR.use_cassette('create and load comment') do
      @user = Insightly::User.all.first

      @task = Insightly::Task.new
      @task.title = "000 Test Task"
      @task.status = "Completed"
      @task.owner_user_id = @user.user_id
      @task.responsible_user_id = @user.user_id
      @task.save
      @task.comment_on("Sample Comment")
      @saved_comment = @task.comments.first


      @comment = Insightly::Comment.new(@saved_comment.comment_id)
      @comment.comment_id.should == @saved_comment.comment_id
      @comment.body.should == @saved_comment.body


    end
  end
  it "should allow you to build an object from a hash" do
    comment = Insightly::Comment.new.build({"BODY" => "Other"})
    comment.remote_data.should == {"BODY" => "Other"}
  end
  context "xml" do
    before(:each) do
      @raw_xml = <<-END_XML
<?xml version="1.0" encoding="utf-8"?>
        <Comment xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
        <COMMENT_ID>132456</COMMENT_ID>
        <BODY>test comment</BODY>
        <OWNER_USER_ID>12345</OWNER_USER_ID>
        <DATE_CREATED_UTC>2012-03-09T23:59:19.503</DATE_CREATED_UTC>
        <DATE_UPDATED_UTC>2012-03-09T23:59:19.503</DATE_UPDATED_UTC>
        <FILE_ATTACHMENTS></FILE_ATTACHMENTS>
        </Comment>
      END_XML
    end
    it "should be able to parse the xml into a valid comment" do
      @comment = Insightly::Comment.new.load_from_xml(@raw_xml)
      @comment.comment_id.should == 132456
      @comment.body.should == "test comment"
      @comment.date_created_utc.should == "2012-03-09T23:59:19.503"
      @comment.date_updated_utc.should == "2012-03-09T23:59:19.503"
      @comment.owner_user_id.should == 12345

    end
    it "should be able to generate xml from the commment" do
      @comment = Insightly::Comment.new.load_from_xml(@raw_xml)
      @comment.to_xml.should == @raw_xml
    end
  end

  it "should allow you to modify a comment" do
    VCR.use_cassette('create and modify comment') do
      @user = Insightly::User.all.first

      @task = Insightly::Task.new
      @task.title = "000 Test Task"
      @task.status = "Completed"
      @task.owner_user_id = @user.user_id
      @task.responsible_user_id = @user.user_id
      @task.save
      @task.comment_on("Sample Comment")
      @saved_comment = @task.comments.first

      @comment = Insightly::Comment.new(@saved_comment.comment_id)
      @comment.body.should == "Sample Comment"

      value = "Test Comment Edit Now"
      @comment.body = value
      @comment.save
      @comment.body.should == value
      @comment.reload
      @comment.body.should == value

    end


  end


end
