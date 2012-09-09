require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Insightly::OpportunityStateReason do
  before(:each) do
    Insightly::Configuration.api_key = INSIGHTLY_API_KEY
    Insightly::Configuration.logger = Insightly::Configuration._debug_logger


    @open_state = Insightly::OpportunityStateReason.build({"STATE_REASON_ID" => 100,
                                                           "FOR_OPPORTUNITY_STATE" => "Open",
                                                           "STATE_REASON" => "Referral"})
    @lost_state = Insightly::OpportunityStateReason.build({"STATE_REASON_ID" => 101,
                                                           "FOR_OPPORTUNITY_STATE" => "Lost",
                                                           "STATE_REASON" => "Chose the other guy"})
    @abandoned_state = Insightly::OpportunityStateReason.build({"STATE_REASON_ID" => 102,
                                                                "FOR_OPPORTUNITY_STATE" => "Abandoned",
                                                                "STATE_REASON" => "No phone number."})
    @won_state = Insightly::OpportunityStateReason.build({"STATE_REASON_ID" => 103,
                                                          "FOR_OPPORTUNITY_STATE" => "Won",
                                                          "STATE_REASON" => "They converted"})
    @suspended_state = Insightly::OpportunityStateReason.build({"STATE_REASON_ID" => 104,
                                                                "FOR_OPPORTUNITY_STATE" => "Suspended",
                                                                "STATE_REASON" => "Follow up at Xmas"})
    @all_states = [@open_state, @lost_state, @abandoned_state, @won_state, @suspended_state]
    #  @task_links = Insightly::TaskLink.all
    #  d = 1
  end
  it "should have a url base" do
    Insightly::OpportunityStateReason.new.url_base.should == "OpportunityStateReasons"
  end
  it "should know the opportunity state" do
    @open_state.state.should == "Open"
  end
  context "remote query" do
    before(:each) do
      Insightly::OpportunityStateReason.any_instance.stub(:get_collection).and_return(@all_states.collect { |x| x.remote_data })
    end
    it "should return nil if there is no match for state and reason" do
       Insightly::OpportunityStateReason.find_by_state_reason("Won","They hated us.").should be nil
       Insightly::OpportunityStateReason.find_by_state_reason("Wont","They converted").should be nil
       Insightly::OpportunityStateReason.find_by_state_reason("Wont","They hated us.").should be nil
    end
    it "should return a opportunity state reason if you search by state and reason" do
      Insightly::OpportunityStateReason.find_by_state_reason("Won","They converted").should == @won_state
    end
    it "should return nil if there is no match for the reason in a given state" do
      Insightly::OpportunityStateReason.won("They hated us.").should be nil

    end
    it "should return an opportunity state reason if you search for a reason for a given state" do
      Insightly::OpportunityStateReason.won("They converted").should == @won_state
    end
    it "should be able to pull down all of them" do
      Insightly::OpportunityStateReason.all.should == @all_states
    end

    it "should pull reasons for Open" do
      Insightly::OpportunityStateReason.open.should == [@open_state]
    end
    it "should pull reasons for Lost" do
      Insightly::OpportunityStateReason.lost.should == [@lost_state]
    end
    it "should pull reasons for Abandoned" do
      Insightly::OpportunityStateReason.abandoned.should == [@abandoned_state]
    end
    it "should pull reasons for Won" do
      Insightly::OpportunityStateReason.won.should == [@won_state]
    end
    it "should pull reasons for Suspended" do

      Insightly::OpportunityStateReason.suspended.should == [@suspended_state]
    end

  end


end
