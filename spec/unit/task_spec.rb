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
  it "should be able to create a task"  do
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
end
