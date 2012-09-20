require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Insightly::Task do
  before(:each) do
    Insightly::Configuration.api_key = INSIGHTLY_API_KEY
    Insightly::Configuration.logger = Insightly::Configuration._debug_logger
    @task = Insightly::Task.new.build({
                                          "TASKLINKS" => {"OPPORTUNITY_ID" => 955454,
                                                          "TASK_LINK_ID" => 2744236,
                                                          "PROJECT_ID" => nil,
                                                          "CONTACT_ID" => nil,
                                                          "TASK_ID" => nil,
                                                          "ORGANIZATION_ID" => nil
                                          },
                                          "STATUS" => "NOT STARTED",
                                          "OWNER_USER_ID" => 226277,
                                          "RESPONSIBLE_USER_ID" => 226277,
                                          "PUBLICLY_VISIBLE" => true,
                                          "PARENT_TASK_ID" => nil,
                                          "COMPLETED_DATE_UTC" => nil,
                                          "CATEGORY_ID" => 125618,
                                          "PERCENT_COMPLETE" => 0,
                                          "START_DATE" => 0,
                                          "PRIORITY" => 2,
                                          "DETAILS" => "Make sure you log into the app to set the flag.",
                                          "DUE_DATE" => "2012-09-05 16:12:20",
                                          "PROJECT_ID" => nil,
                                          "COMPLETED" => false,
                                          "TASK_ID" => 3216775,
                                          "DATE_CREATED_UTC" => "2012-09-05 16:12:20",
                                          "TITLE" => "Flag the Customer"
                                      })

    # @task = Insightly::Task.new(3216775)
  end
  it "should be able to create a task" do
  end
  it "should have a url base" do
    @task.url_base.should == "Tasks"
  end
  it "should know the task id" do
    @task.task_id.should == 3216775
  end
  it "should know that the remote id and the task id are the same" do
    @task.remote_id.should == @task.task_id
  end
  it "should allow you to load based on an id"
  it "should allow you to build an object from a hash" do
    task = Insightly::Task.new.build({"TITLE" => "Other"})
    task.remote_data.should == {"TITLE" => "Other"}
  end
  it "should know the status of the task" do
    @task.status.should == "NOT STARTED"
  end
  context "comments" do
    before(:each) do
      #@task = Insightly::Task.new(3216775)
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

    end
    it "should be able to fetch the comments" do
      Insightly::Task.any_instance.should_receive(:get_collection).with("Tasks/#{@task.task_id}/comments").and_return([@comment.remote_data])
      comments = @task.comments
      comments.length.should == 1
      comments.first.body.should == "test comment"
    end
    it "should be able to post a new comment" do
      value= "Test Comment #{Time.now}"
      @comment.body = value
      incoming_comment = Insightly::Comment.new.build({"BODY" => value})
      Insightly::Task.any_instance.should_receive(:post_collection).with("Tasks/#{@task.task_id}/comments", incoming_comment.remote_data.to_json).and_return(@comment.remote_data)
      #@task = Insightly::Task.new(3216775)

      result = @task.comment_on(value)
      result.comment_id.should_not be_nil
      result.body.should == value
    end
  end
  context "Status query" do
    before(:each) do
      @statuses = ["NOT STARTED", "IN PROGRESS", "WAITING", "COMPLETED", "DEFERRED"]
    end
    it "should know that is it not started" do
      @statuses.each do |s|
        @task.status = s
        s == "NOT STARTED" ? (@task.should be_not_started) : (@task.should_not be_not_started)
      end
    end
    it "should know that is it in progress" do
      @statuses.each do |s|
        @task.status = s
        s == "IN PROGRESS" ? (@task.should be_in_progress) : (@task.should_not be_in_progress)
      end
    end
    it "should know that is it waiting" do
      @statuses.each do |s|
        @task.status = s
        s == "WAITING" ? (@task.should be_waiting) : (@task.should_not be_waiting)
      end
    end
    it "should know that is it completed" do
      @statuses.each do |s|
        @task.status = s
        s == "COMPLETED" ? (@task.should be_completed) : (@task.should_not be_completed)
      end
    end
    it "should know that is it deferred" do
      @statuses.each do |s|
        @task.status = s
        s == "DEFERRED" ? (@task.should be_deferred) : (@task.should_not be_deferred)
      end
    end


  end
  it "should be able to link a task to an opportunity" do
    @opportunity = Insightly::Opportunity.build({

                                                    "VISIBLE_TO" => "EVERYONE",
                                                    "BID_TYPE" => "Fixed Bid",
                                                    "ACTUAL_CLOSE_DATE" => nil,
                                                    "BID_CURRENTY" => "USD",
                                                    "OPPORTUNITY_STATE" => "Open",
                                                    "OPPORTUNITY_NAME" => "Linkable Opportunity",
                                                    "OPPORTUNITY_DETAILS" => "This is a description."
                                                })

    @task = Insightly::Task.new.build({


                                            "PUBLICLY_VISIBLE" => true,
                                            "RESPONSIBLE_USER_ID" => "226277" ,
                                                "OWNER_USER_ID" =>  "226277"   ,
                                            "DETAILS" => "This proves we can link them",

                                            "TITLE" => "Linkable Task"
                                        })
   # @opportunity.save
    @opportunity = Insightly::Opportunity.new(968613)
    @task.save
    #"TASKLINKS" => {"OPPORTUNITY_ID" => 955454,
    #                                                         "TASK_LINK_ID" => 2744236,
    #                                                        "PROJECT_ID" => nil,
    #                                                        "CONTACT_ID" => nil,
    #                                                        "TASK_ID" => nil,
    #                                                        "ORGANIZATION_ID" => nil
    #                                                                           },
    @task_link = Insightly::TaskLink.build("OPPORTUNITY_ID" => @opportunity.opportunity_id.to_s,
                                           "TASK_ID" => @task.task_id.to_s
                                          )
    @task.tasklinks = [@task_link.remote_data]
    @task.save
  end

  context "TaskLinks" do
     before(:each) do
      # @task = Insightly::Task.new(3263739)
        @task = Insightly::Task.new
       @task.task_links = []
      # @task.save
 
 
       @link = Insightly::TaskLink.add_organisation(8936117)
       @link2 = Insightly::TaskLink.add_opportunity(968613)
     end
     it "should allow you to try to set it to nil" do
       @task = Insightly::Task.new
       @task.task_links = nil
       @task.task_links.should == []
     end
     it "should allow you to update an link" do
       @task.task_links.should == []
       @task.add_task_link(@link)
 
       @task.save
       @link = @task.task_links.first
       @link2.task_link_id = @link.task_link_id
       @task.task_links = [@link2]
       @task.save
       @task.reload
       @task.task_links.length.should == 1
       @task.task_links.first.opportunity_id.should == 968613
     end
     it "should allow you to add an link" do
 
 
       @task.task_links.should == []
       @task.add_task_link(@link)

       @task.save
       @task.reload
       @task.task_links.length.should == 1
       @task.task_links.first.organisation_id.should == 8936117
     end
     it "should allow you to remove an link" do
 
       @task.task_links.should == []
       @task.add_task_link(@link)
 
       @task.save
       @task.task_links = []
       @task.save
       @task.reload
       @task.task_links.length.should == 0
 
     end
     it "should allow you to clear all links" do
       @task.task_links.should == []
       @task.add_task_link(@link)
 
       @task.save
       @task.task_links = []
       @task.save
       @task.reload
       @task.task_links.length.should == 0
     end
   end
end
