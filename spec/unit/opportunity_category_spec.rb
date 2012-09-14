require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Insightly::OpportunityCategory do
  before(:each) do
    Insightly::Configuration.api_key = INSIGHTLY_API_KEY
    Insightly::Configuration.logger = Insightly::Configuration._debug_logger

    @opportunity_category = Insightly::OpportunityCategory.build({ "CATEGORY_ID" => 1,
                                                                   "ACTIVE" => true,
                                                                   "BACKGROUND_COLOR" => '019301',
                                                                   "CATEGORY_NAME" => "Referral"})

    @opportunity_category2 = Insightly::OpportunityCategory.build({ "CATEGORY_ID" => 2,
                                                                   "ACTIVE" => true,
                                                                   "BACKGROUND_COLOR" => '019301',
                                                                   "CATEGORY_NAME" => "Other"})
   @all_opportunity_categories = [@opportunity_category, @opportunity_category2]
  end
  it "should have a url base" do
    Insightly::OpportunityCategory.new.url_base.should == "OpportunityCategories"
  end
  it "should be able to fetch all of the opportunity_categories" do

      Insightly::OpportunityCategory.any_instance.stub(:get_collection).and_return(@all_opportunity_categories.collect { |x| x.remote_data })
      Insightly::OpportunityCategory.all.should == @all_opportunity_categories

  end
  it "should have a remote id" do
    @opportunity_category.remote_id.should ==   @opportunity_category.category_id
  end
  it "should be able to retrieve the data as an array" do
    @opportunity_category.remote_data["CATEGORY_NAME"].should == "Referral"
  end
  it "should be able to convert to json" do
      @opportunity_category.to_json.should == @opportunity_category.remote_data.to_json
  end

  it "should know if two opportunity_categories are equal" do
    @opportunity_category2 = Insightly::OpportunityCategory.build(@opportunity_category.remote_data.clone)
    @opportunity_category2.should == @opportunity_category
    @opportunity_category.category_name = "Bob"
    @opportunity_category2.should_not == @opportunity_category
  end

  it "should have accessor forcategory_name" do
    @opportunity_category.category_name = "Will"
    @opportunity_category.category_name.should == "Will"
  end

end
