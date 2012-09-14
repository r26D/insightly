require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Insightly::OpportunityStateReason do
  before(:each) do
    Insightly::Configuration.api_key = INSIGHTLY_API_KEY
    Insightly::Configuration.logger = Insightly::Configuration._debug_logger
    @user = Insightly::User.build({
                                      "DATE_UPDATED_UTC" => "2010-12-27 04:22:00",
                                      "DATE_CREATED_UTC" => "2010-12-27 04:22:00",
                                      "ACTIVE" => true,
                                      "TIMEZONE_ID" => "Central Standard Time",
                                      "EMAIL_ADDRESS" => "bob@aol.com",
                                      "ACCOUNT_OWNER" => false,
                                      "CONTACT_ID" => 123456789,
                                      "USER_ID" => 1,
                                      "ADMINISTRATOR" => true,
                                      "LAST_NAME" => "Campbell",
                                      "FIRST_NAME" => "Ron"
                                  })
    @user2 = Insightly::User.build({
                                       "DATE_UPDATED_UTC" => "2010-12-27 04:22:00",
                                       "DATE_CREATED_UTC" => "2010-12-27 04:22:00",
                                       "ACTIVE" => true,
                                       "TIMEZONE_ID" => "Central Standard Time",
                                       "EMAIL_ADDRESS" => "allen@aol.com",
                                       "ACCOUNT_OWNER" => false,
                                       "CONTACT_ID" => 923456789,
                                       "USER_ID" => 2,
                                       "ADMINISTRATOR" => true,
                                       "LAST_NAME" => "Campbell",
                                       "FIRST_NAME" => "Allen"
                                   })
    @all_users
  end
  it "should have a url base" do
    Insightly::User.new.url_base.should == "Users"

  end
  it "should get the user id" do
    @user.user_id.should == 1
  end
  it "should have a remote id" do
    @user.remote_id.should == @user.user_id
  end
  context "search/find" do
    before(:each) do
      Insightly::User.any_instance.stub(:get_collection).and_return(@all_users.collect { |x| x.remote_data })
    end
    it "should be able to pull all of them" do

    end
    it "should be able to fetch the name of a user"
    it "should be able to get the last name first of a user"
    it "should allow you to find someone by their email"
    it "should allow you to find a list by their email"
    it "should allow you to find someone by their name"
    it "should allow you to find a list by their name"
    it "should allow you to find somone by part of an email"
    it "should allow you to find a list by part of an email"
    it "should allow you to find a list by part of a name"
    it "should allow you to find someone by part of a name"
  end

end