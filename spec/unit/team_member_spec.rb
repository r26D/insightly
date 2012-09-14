require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Insightly::TeamMember do
  before(:each) do
    Insightly::Configuration.api_key = INSIGHTLY_API_KEY
    Insightly::Configuration.logger = Insightly::Configuration._debug_logger


    @team_member = Insightly::TeamMember.build({"MEMBER_TEAM_ID" => nil,
                                                "TEAM_ID" => 1,
                                               "MEMBER_USER_ID" => 100,
                                               "PERMISSION_ID" => 2000})
    @team_member2 = Insightly::TeamMember.build({"MEMBER_TEAM_ID" => nil,
                                                "TEAM_ID" => 1,
                                               "MEMBER_USER_ID" => 101,
                                               "PERMISSION_ID" => 2000})

    @all_team_members = [@team_member, @team_member2]
  end
  it "should have a url base" do
    Insightly::TeamMember.new.url_base.should == "TeamMembers"
  end
  it "should be able to fetch all" do

      Insightly::TeamMember.any_instance.stub(:get_collection).and_return(@all_team_members.collect { |x| x.remote_data })
      Insightly::TeamMember.all.should == @all_team_members

  end
  it "should have be able to ask the team id" do
    @team_member.team_id.should == 1
  end
  it "should have a remote id" do
    @team_member.remote_id.should == @team_member.team_id
  end

end
