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
                                      "EMAIL_ADDRESS" => "ron@aol.com",
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
    @all_users  = [@user, @user2]
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
  context "name" do
    before(:each) do
      @user = Insightly::User.build({"FIRST_NAME" => "Ron", "LAST_NAME" => "Campbell"})
    end

    it "should return the name" do

      @user.name.should == "Ron Campbell"
    end
    it "should handle nil first name" do
      @user.first_name = nil
      @user.name.should == "Campbell"
    end
    it "should handle nil last name" do
      @user.last_name = nil
      @user.name.should == "Ron"
    end
    it "should handle empty first name" do
      @user.first_name = ""
      @user.name.should == "Campbell"
    end
    it "should handle empty last name" do
      @user.last_name = ""
      @user.name.should == "Ron"
    end
    it "should handle nil first and last name" do
      @user.first_name = nil
      @user.last_name = nil
      @user.name.should == ""
    end
    it "should handle empty first and last name" do
      @user.first_name = ""
      @user.last_name = ""
      @user.name.should == ""
    end
  end
  context "last_name_first" do
    before(:each) do
      @user = Insightly::User.build({"FIRST_NAME" => "Ron", "LAST_NAME" => "Campbell"})
    end

    it "should return the last name first" do

      @user.last_name_first.should == "Campbell,Ron"
    end
    it "should handle nil first name" do
      @user.first_name = nil
      @user.last_name_first.should == "Campbell,"
    end
    it "should handle nil last name" do
      @user.last_name = nil
      @user.last_name_first.should == ",Ron"
    end
    it "should handle empty first name" do
      @user.first_name = ""
      @user.last_name_first.should == "Campbell,"
    end
    it "should handle empty last name" do
      @user.last_name = ""
      @user.last_name_first.should == ",Ron"
    end
    it "should handle nil first and last name" do
      @user.first_name = nil
      @user.last_name = nil
      @user.last_name_first.should == ""
    end
    it "should handle empty first and last name" do
      @user.first_name = ""
      @user.last_name = ""
      @user.last_name_first.should == ""
    end
  end
  context "search/find" do
    before(:each) do
      Insightly::User.any_instance.stub(:get_collection).and_return(@all_users.collect { |x| x.remote_data })
    end
    it "should be able to pull all of them" do
      Insightly::User.all.should == @all_users
    end

    it "should return nil if not found by email" do
          Insightly::User.find_by_email("will").should be_nil
    end
    it "should return nil if not found by email" do
          Insightly::User.find_by_email("will").should be_nil
    end
    it "should return [] if not found all by email" do
          Insightly::User.find_all_by_email("will").should == []
    end
    it "should return [] if not found all by name" do
          Insightly::User.find_all_by_name("will").should == []
    end

    it " should allow you to find someone by their email " do
      Insightly::User.find_by_email("ron@aol.com").should == @user
    end
    it " should allow you to find a list by their email " do
      Insightly::User.find_all_by_email("ron@aol.com").should == [ @user]
    end
    it " should allow you to find someone by their name " do

      Insightly::User.find_by_name("Ron Campbell").should == @user
    end
    it " should allow you to find a list by their name " do
      Insightly::User.find_all_by_name("Ron Campbell").should == [@user]
    end
    it " should allow you to find somone by part of an email " do
      Insightly::User.find_by_email("ron").should == @user
    end
    it " should allow you to find a list by part of an email " do
      Insightly::User.find_by_email("aol.com").should == @user
    end
    it " should allow you to find a list by part of a name " do
      Insightly::User.find_by_name("Ron").should == @user
    end
    it " should allow you to find someone by part of a name " do
      Insightly::User.find_all_by_name("Campbell").should == [@user, @user2]
    end
  end

end