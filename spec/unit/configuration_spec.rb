require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")


describe Insightly::Configuration do
  #customer_user_agent
  #endpoint
  #logger
  #api_key
  before(:each) do
    Insightly::Configuration.custom_user_agent = nil
    Insightly::Configuration.api_key = "123"
    Insightly::Configuration.endpoint = nil
  end
  it "should provide a default user agent" do

    Insightly::Configuration.instantiate.custom_user_agent.should be_nil
    Insightly::Configuration.instantiate.user_agent.should == "Insightly Ruby Gem #{Insightly::Version::String}"
  end
  it "should allow you to override the user agent" do

    Insightly::Configuration.custom_user_agent = "Bob"
    Insightly::Configuration.instantiate.user_agent.should == "Insightly Ruby Gem #{Insightly::Version::String} (Bob)"
  end
  it "should provide a default endpoint" do
    Insightly::Configuration.instantiate.endpoint.should == "https://api.insight.ly/v1"
  end
  it "should allow you to override the endpoint" do
    Insightly::Configuration.endpoint = "Bob"
    Insightly::Configuration.instantiate.endpoint.should == "Bob"
  end
  it "should raise an error if you do not set an api key" do
    Insightly::Configuration.instance_variable_set(:@api_key, nil)
    expect do
      Insightly::Configuration.api_key
    end.to raise_error(Insightly::ConfigurationError, "Insightly::Configuration.api_key needs to be set")
    expect do
         Insightly::Configuration.instantiate.api_key
       end.to raise_error(Insightly::ConfigurationError, "Insightly::Configuration.api_key needs to be set")
  end
  it "should allow you to set the api_key" do
    Insightly::Configuration.api_key = "Bob"
    Insightly::Configuration.api_key.should == "Bob"
    Insightly::Configuration.instantiate.api_key.should == "Bob"
  end
  it "should be able to set custom fields for opportunities" do
    Insightly::Opportunity.should_receive(:custom_fields).with(:rank, :branch_of_service)

    Insightly::Configuration.custom_fields_for_opportunities(:rank, :branch_of_service)

  end
  it "should be able to set custom fields for contacts" do
    Insightly::Contact.should_receive(:custom_fields).with(:rank, :branch_of_service)

    Insightly::Configuration.custom_fields_for_contacts(:rank, :branch_of_service)

  end
  it "should be able to set custom fields for organisations" do
    Insightly::Organisation.should_receive(:custom_fields).with(:rank, :branch_of_service)

    Insightly::Configuration.custom_fields_for_organisations(:rank, :branch_of_service)

  end
end
