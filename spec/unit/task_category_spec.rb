require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Insightly::TaskCategory do
  before(:each) do
    Insightly::Configuration.api_key = INSIGHTLY_API_KEY
    Insightly::Configuration.logger = Insightly::Configuration._debug_logger

    @all = Insightly::TaskCategory.all

    @task_category = Insightly::TaskCategory.build({ "CATEGORY_ID" => 1,
                                                                   "ACTIVE" => true,
                                                                   "BACKGROUND_COLOR" => '019301',
                                                                   "CATEGORY_NAME" => "Meeting"})

    @task_category2 = Insightly::TaskCategory.build({ "CATEGORY_ID" => 2,
                                                                   "ACTIVE" => true,
                                                                   "BACKGROUND_COLOR" => '019301',
                                                                   "CATEGORY_NAME" => "Phone call"})
   @all_task_categories = [@task_category, @task_category2]
  end
  it "should have a url base" do
    Insightly::TaskCategory.new.url_base.should == "TaskCategories"
  end
  it "should be able to fetch all of the task_categories" do

      Insightly::TaskCategory.any_instance.stub(:get_collection).and_return(@all_task_categories.collect { |x| x.remote_data })
      Insightly::TaskCategory.all.should == @all_task_categories

  end
  it "should have a remote id" do
    @task_category.remote_id.should ==   @task_category.category_id
  end
  it "should be able to retrieve the data as an array" do
    @task_category.remote_data["CATEGORY_NAME"].should == "Meeting"
  end
  it "should be able to convert to json" do
      @task_category.to_json.should == @task_category.remote_data.to_json
  end

  it "should know if two task_categories are equal" do
    @task_category2 = Insightly::TaskCategory.build(@task_category.remote_data.clone)
    @task_category2.should == @task_category
    @task_category.category_name = "Bob"
    @task_category2.should_not == @task_category
  end

  it "should have accessor for category_name" do
    @task_category.category_name = "Will"
    @task_category.category_name.should == "Will"
  end

end
