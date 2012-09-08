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
    #METODO This should create the comment so we can make sure it exists - once that feature is available
    @comment = Insightly::Comment.new(768880)
    @comment.comment_id.should == 768880
  end
  it "should allow you to build an object from a hash" do
    comment = Insightly::Comment.new.build({"BODY" => "Other"})
    comment.remote_data.should == {"BODY" => "Other"}
  end



end
