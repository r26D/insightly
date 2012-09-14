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
    Insightly::Configuration.custom_fields_for_opportunities(:dummy1,
                                                             :admin_url,
                                                             :phone_number,
                                                             :timezone,
                                                             :plan,
                                                             :organization,
                                                             :company_name,
                                                             :contact_name)

    o = Insightly::Opportunity.new
    o.opportunity_state = "Open"
    o.visible_to = "EVERYONE"
    o.stage_id = "71162"
    o.forecast_close_date = "2012-10-05 00:00:00"
    o.responsible_user_id = "226277"
    o.bid_currency = "USD"
    o.opportunity_details = "This is the description"
    o.category_id = "628187" #First plan list
    o.bid_amount = "75"
    o.pipeline_id = "24377"
    o.opportunity_name = "Sample Opportunity 3"
    o.contact_name = "Dirk ELmendorf"
    o.company_name = "r26D"
    o.organization = "TruckingOffice"
    o.plan = "Owner/Operator"
    o.timezone = "Central"
    o.phone_number = "210-555-1212"
    o.admin_url = "https://admin/companies/122"
    o.bid_type = "Fixed Bid"
    o.owner_user_id = "226277"
    o.save
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
    fields = Insightly::Opportunity.api_fields

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
  context "search/find" do
    before(:each) do
      @opp1 = Insightly::Opportunity.build(@opportunity.remote_data.clone)
      @opp1.opportunity_name = "Apple Sale"
      @opp2 = Insightly::Opportunity.build(@opportunity.remote_data.clone)
      @opp2.opportunity_name = "Apple Sale 2"
      @opp3 = Insightly::Opportunity.build(@opportunity.remote_data.clone)
      @opp3.opportunity_name = "Box Sale"
      @opp4 = Insightly::Opportunity.build(@opportunity.remote_data.clone)
      @opp4.opportunity_name = nil

      Insightly::Opportunity.should_receive(:all).and_return([@opp1, @opp2, @opp3, @opp4])

    end
    it "should find all the names that match" do
      Insightly::Opportunity.search_by_name("Apple").should == [@opp1, @opp2]
    end
    it "should return an empty array if there are not matches" do
      Insightly::Opportunity.search_by_name("Cobra").should == []
    end
    it "should find the first one that is exactly the right" do
      Insightly::Opportunity.find_by_name("Apple Sale 2").should == @opp2
    end
    it "should return nil if no opportunity name is found" do
      Insightly::Opportunity.find_by_name("Cobra").should == nil
    end
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
    it "should allow you to change the state without a reason" do
      @opportunity = Insightly::Opportunity.new(957168)

      @opportunity.open!
      @opportunity.lost!
      @opportunity.should be_lost
      @opportunity.reload
      @opportunity.should be_lost
    end
    it "should allow you to provide a reason - and the state should change if the reason isn't valid" do
      @opportunity = Insightly::Opportunity.new(957168)

      @opportunity.open!
      @opportunity.won!("Bobobob")
      @opportunity.reload
      @opportunity.should be_won
    end

    it "should allow you to change the state and set the reason" do
      @opportunity = Insightly::Opportunity.new(957168)
      Insightly::OpportunityStateReason.find_by_state_reason("Won", "They converted").should_not be_nil

      @opportunity.open!
      @opportunity.won!("They converted")
      @opportunity.reload
      @opportunity.should be_won
      # Currently there is no way to test the reason is set

    end
    it "should set the reason to Created by API if you create an opportunity"

  end
  context "connections" do
    before(:each) do
      @opportunity = Insightly::Opportunity.new(968613)
      @opportunity.links = []
      @opportunity.tags = []
      @opportunity.save
    end

    context "Links" do
      before(:each) do


        @link = Insightly::Link.add_organisation(8936117, "Employeer", "Handles payment")
        # @link = Insightly::Link.add_contacty(20315449,"Janitor", "Recent Hire")
      end
      it "should allow you to update an link" do
        @opportunity.links.should == []
        @opportunity.add_link(@link)

        @opportunity.save
        @link = @opportunity.links.first
        @link.details = "Old Veteran"
        @opportunity.links = [@link]
        @opportunity.save
        @opportunity.reload
        @opportunity.links.length.should == 1
        @opportunity.links.first.details.should == "Old Veteran"
      end
      it "should allow you to add an link" do


        @opportunity.links.should == []
        @opportunity.add_link(@link)
        @opportunity.add_link(@link)
        @opportunity.links.length.should == 2
        @opportunity.save
        @opportunity.reload
        @opportunity.links.length.should == 1
        @opportunity.links.first.details.should == "Handles payment"
      end
      it "should allow you to remove an link" do

        @opportunity.links.should == []
        @opportunity.add_link(@link)

        @opportunity.save
        @opportunity.links = []
        @opportunity.save
        @opportunity.reload
        @opportunity.links.length.should == 0

      end
      it "should allow you to clear all links" do
        @opportunity.links.should == []
        @opportunity.add_link(@link)

        @opportunity.save
        @opportunity.links = []
        @opportunity.save
        @opportunity.reload
        @opportunity.links.length.should == 0
      end
    end
    context "Tags" do
      before(:each) do

        @tag = Insightly::Tag.build("Paying Customer")
        @tag2 = Insightly::Tag.build("Freebie")

      end
      it "should allow you to update an tag" do
        @opportunity.tags.should == []
        @opportunity.add_tag(@tag)
        @tags = @opportunity.tags

        @opportunity.save
        @tag = @opportunity.tags.first
        @tag.tag_name = "Old Veteran"
        @opportunity.tags = [@tag]
        @opportunity.save
        @opportunity.reload
        @opportunity.tags.length.should == 1
        @opportunity.tags.first.tag_name.should == "Old Veteran"
      end
      it "should allow you to add an tag" do


        @opportunity.tags.should == []
        @opportunity.add_tag(@tag)
        @opportunity.add_tag(@tag)
        @opportunity.tags.length.should == 2
        @opportunity.save
        @opportunity.reload
        @opportunity.tags.length.should == 1
        @opportunity.tags.first.tag_name.should == "Paying Customer"
      end
      it "should allow you to remove an tag" do

        @opportunity.tags.should == []
        @opportunity.add_tag(@tag)

        @opportunity.save
        @opportunity.tags = []
        @opportunity.save
        @opportunity.reload
        @opportunity.tags.length.should == 0

      end
      it "should allow you to clear all tags" do
        @opportunity.tags.should == []
        @opportunity.add_tag(@tag)

        @opportunity.save
        @opportunity.tags = []
        @opportunity.save
        @opportunity.reload
        @opportunity.tags.length.should == 0
      end
    end
  end
end
