require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Insightly::Opportunity do
  before(:each) do
    Insightly::Configuration.api_key = INSIGHTLY_API_KEY
    Insightly::Configuration.logger = Insightly::Configuration._debug_logger
    @opportunity = Insightly::Opportunity.build({
                                                    "OPPORTUNITY_FIELD_10" => nil,
                                                    "OPPORTUNITY_FIELD_9" => nil,
                                                    "OPPORTUNITY_FIELD_8" => "Bob Roberts",
                                                    "OPPORTUNITY_FIELD_7" => "r26D Trucking",
                                                    "OPPORTUNITY_FIELD_6" => "TruckingOffice",
                                                    "OPPORTUNITY_FIELD_5" => "Owner/Operator",
                                                    "OPPORTUNITY_FIELD_4" => "Central",
                                                    "OPPORTUNITY_FIELD_3" => "210-555-1212",
                                                    "OPPORTUNITY_FIELD_2" => "http://www.truckingoffice.com/522",
                                                    "OPPORTUNITY_FIELD_1" => nil,
                                                    "VISIBLE_TO" => "EVERYONE",
                                                    "BID_TYPE" => "Fixed Bid",
                                                    "ACTUAL_CLOSE_DATE" => nil,
                                                    "DATE_UPDATED_UTC" => "2012-06-06 02:05:34",
                                                    "OWNER_USER_ID" => 226277,
                                                    "BID_DURATION" => nil,
                                                    "BID_CURRENTY" => "USD",
                                                    "PIPELINE_ID" => 24377,
                                                    "CATEGORY_ID" => 628187,
                                                    "PROBABILITY" => nil,
                                                    "TAGS" => [],
                                                    "IMAGE_URL" => "http://s3.amazonaws.com/insightly.userfiles/20562/",
                                                    "BID_AMOUNT" => 20,
                                                    "VISIBLE_TEAM_ID" => nil,
                                                    "STAGE_ID" => 71162,
                                                    "DATE_CREATED_UTC" => "2012-09-06 02:04:47",
                                                    "OPPORTUNITY_STATE" => "OPEN",
                                                    "FORECAST_CLOSE_DATE" => "2012-10-05 00:00:00",
                                                    "OPPORTUNITY_NAME" => "Sample Opportunity",
                                                    "OPPORTUNITY_ID" => 957168,
                                                    "VISIBLE_USER_IDS" => nil,
                                                    "LINKS" => [],
                                                    "RESPONSIBLE_USER_ID" => 226277,
                                                    "OPPORTUNITY_DETAILS" => "This is a description."

                                                })
  end
  it "should be able to create a opportunity" do
  end
  it "should have a url base" do
    @opportunity.url_base.should == "Opportunities"
  end
  it "should know the opportunity id" do
    @opportunity.opportunity_id.should == 957168
  end
  it "should know that the remote id and the opportunity id are the same" do
    @opportunity.remote_id.should == @opportunity.opportunity_id
  end
  it "should allow you to load based on an id"
  it "should allow you to build an object from a hash" do
    opportunity = Insightly::Opportunity.new.build({"TITLE" => "Other"})
    opportunity.remote_data.should == {"TITLE" => "Other"}
  end
  it "should have allow you to read and write all fields" do
    Insightly::Opportunity.api_fields.each do |f|
      @opportunity.send(f.downcase.to_sym).should == @opportunity.remote_data[f]
      @opportunity.send("#{f.downcase}=".to_sym, "Bob")
      @opportunity.send(f.downcase.to_sym).should == "Bob"
      @opportunity.remote_data[f].should == "Bob"
    end
  end
  it "should allow you to define custom field labels" do
    Insightly::Opportunity.custom_fields(:dummy1, :dummy2, :dummy3)
    @opportunity.dummy1.should == @opportunity.remote_data["OPPORTUNITY_FIELD_1"]
    @opportunity.dummy2.should == "http://www.truckingoffice.com/522"
    @opportunity.dummy3.should == @opportunity.remote_data["OPPORTUNITY_FIELD_3"]

    @opportunity.dummy1 = "Bob1"
    @opportunity.dummy2 = "Bob2"
    @opportunity.dummy3 = "Bob3"

    @opportunity.dummy1.should == "Bob1"
    @opportunity.dummy2.should == "Bob2"
    @opportunity.dummy3.should == "Bob3"
    @opportunity.remote_data["OPPORTUNITY_FIELD_1"].should == "Bob1"
    @opportunity.remote_data["OPPORTUNITY_FIELD_2"].should == "Bob2"
    @opportunity.remote_data["OPPORTUNITY_FIELD_3"].should == "Bob3"
  end
  it "should handle special fields" do
    Insightly::Opportunity.custom_fields(:dummy1, :admin_url, :phone_number, :timezone, :plan, :organization, :company_name, :contact_name)
    @opportunity.admin_url.should == "http://www.truckingoffice.com/522"
    @opportunity.phone_number.should == "210-555-1212"
    @opportunity.timezone.should == "Central"
    @opportunity.plan.should == "Owner/Operator"
    @opportunity.organization.should == "TruckingOffice"
    @opportunity.company_name.should == "r26D Trucking"
    @opportunity.contact_name.should == "Bob Roberts"
  end
  context "State" do
    it "should have state booleans" do

      states = Insightly::OpportunityStateReason::STATES
      states.each do |state|
        opportunity = Insightly::Opportunity.build({"OPPORTUNITY_STATE" => state})

        states.each do |current_state|
          if state == current_state
            opportunity.send("#{current_state.downcase}?".to_sym).should be_true

          else
            opportunity.send("#{current_state.downcase}?".to_sym).should be_false
          end
        end
      end

    end
    it "should be able to search by state" do

    end
    context "Change" do

    end
  end
end
