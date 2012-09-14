require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Insightly::Country do
  before(:each) do
    Insightly::Configuration.api_key = INSIGHTLY_API_KEY
    Insightly::Configuration.logger = Insightly::Configuration._debug_logger
    @country = Insightly::Country.build({"COUNTRY_NAME" => "United States"})
    @country2 = Insightly::Country.build({"COUNTRY_NAME" => "Canada"})
    @all_countries = [@country, @country2]
  end
  it "should have a url base" do
    Insightly::Country.new.url_base.should == "Countries"
  end
  it "should be able to fetch all of the countries" do

      Insightly::Country.any_instance.stub(:get_collection).and_return(@all_countries.collect { |x| x.remote_data })
      Insightly::Country.all.should == @all_countries

  end
  it "should allow you to build a coutnry from a string" do
    @country = Insightly::Country.build("India")
    @country.country_name.should == "India"
    @country.remote_data.should == {"COUNTRY_NAME" => "India"}
  end
  it "should be able to retrieve the data as an array" do
    @country.remote_data["COUNTRY_NAME"].should == "United States"
  end
  it "should be able to convert to json" do
      @country.to_json.should == @country.remote_data.to_json
  end

  it "should know if two countries are equal" do
    @country2 = Insightly::Country.build(@country.remote_data.clone)
    @country2.should == @country
    @country.country_name = "Bob"
    @country2.should_not == @country
  end

  it "should have accessor for country_name" do
    @country.country_name = "Will"
    @country.country_name.should == "Will"
  end
  it "should have a US standard object" do
    Insightly::Country.us.country_name.should == "United States"
  end
  it "should have a Canada standard object" do
    Insightly::Country.canada.country_name.should == "Canada"
  end
end
