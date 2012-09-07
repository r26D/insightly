require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Insightly::TaskLink do
  before(:each) do
    Insightly::Configuration.api_key = INSIGHTLY_API_KEY

    @tl1 = Insightly::TaskLink.new.build({"CONTACT_ID" => 3004829,
                                         "OPPORTUNITY_ID" => nil,
                                         "TASK_ID" => 11751,
                                         "TASK_LINK_ID" => 106710,
                                         "ORGANIZATION_ID" => nil,
                                         "PROJECT_ID" => nil})
    @tl2 = Insightly::TaskLink.new.build({"CONTACT_ID" => nil,
                                         "OPPORTUNITY_ID" => 1000,
                                        "TASK_ID" => 151751,
                                        "TASK_LINK_ID" => 106710,
                                        "ORGANIZATION_ID" => nil,
                                        "PROJECT_ID" => nil})
    #  @task_links = Insightly::TaskLink.all
    #  d = 1
  end
  it "should have a url base" do
    Insightly::TaskLink.new.url_base.should == "TaskLinks"
  end
   it "should know the task id" do
    @tl1.task_id.should ==  11751
        @tl2.task_id.should == 151751
   end
  it "should know the opportunity id" do
    @tl1.opportunity_id.should ==  nil
        @tl2.opportunity_id.should == 1000
  end
  it "should be able to pull down all of them" do

    result = [ @tl1.remote_data, @tl2.remote_data]

    Insightly::TaskLink.any_instance.stub(:get_collection).and_return(result)
    Insightly::TaskLink.all.should == [@tl1,@tl2]
  end
  it "should be able to search by opportunity id" do
    result = [ @tl1.remote_data, @tl2.remote_data]

    Insightly::TaskLink.any_instance.stub(:get_collection).and_return(result)
    Insightly::TaskLink.search_by_opportunity_id(@tl2.opportunity_id).should == [@tl2]
  end

end
