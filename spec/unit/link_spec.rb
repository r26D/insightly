require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Insightly::Link do
  before(:each) do
    Insightly::Configuration.api_key = INSIGHTLY_API_KEY
    @link = Insightly::Link.build({
          "LINK_ID" => 1,
          "ROLE" => "Manager",
          "DETAILS" => "Added 2 weeks ago",
          "CONTACT_ID" => 100,

      })
  end
  it "should be able to build an link from data" do
    data = {
              "LINK_ID" => 1,
              "ROLE" => "Manager",
              "DETAILS" => "Added 2 weeks ago",
              "CONTACT_ID" => 100,
    
          }
    @link = Insightly::Link.build(data)

    @link.remote_data.should == data
  end
  it "should be able to retrieve the data as an array" do
    @link.remote_data["LINK_ID"].should == 1
  end
  it "should be able to convert to json" do
      @link.to_json.should == @link.remote_data.to_json
  end

  it "should know if two linkes are equal" do
    @link2 = Insightly::Link.build(@link.remote_data.clone)
    @link2.should == @link
    @link.role = nil
    @link2.should_not == @link
  end

  it "should have accessor for link_id" do
    @link.link_id = 2
    @link.link_id.should == 2
  end
  it "should have accessor for project_id" do
    @link.project_id = 2
    @link.project_id.should == 2
  end
  it "should have accessor for contact_id" do
    @link.contact_id = 2
    @link.contact_id.should == 2
  end
  it "should have accessor for opportunity_id" do
    @link.opportunity_id = 2
    @link.opportunity_id.should == 2
  end
  it "should have accessor for organisation_id" do
    @link.organisation_id = 2
    @link.organisation_id.should == 2
  end
  it "should have accessor for role" do
    @link.role = "Worker"
    @link.role.should == "Worker"
  end
  it "should have accessor for details" do
    @link.details = "New hire"
    @link.details.should == "New hire"
  end
  it "should make it easy to add a contact" do
    @link = Insightly::Link.add_contact(100,"Consultant", "Charges a lot!")
    @link.contact_id.should == 100
    @link.details.should == "Charges a lot!"
    @link.role.should == "Consultant"
    @link.project_id.should be_nil
    @link.opportunity_id.should be_nil
    @link.organisation_id.should be_nil

  end
  it "should make it easy to add an opportunity" do
    @link = Insightly::Link.add_opportunity(100,"Big Sale", "Quaterly Project")
    @link.opportunity_id.should == 100
    @link.details.should == "Quaterly Project"
    @link.role.should == "Big Sale"
    @link.project_id.should be_nil
    @link.contact_id.should be_nil
    @link.organisation_id.should be_nil

  end
  it "should make it easy to add an organisation" do
    @link = Insightly::Link.add_organisation(100,"Walmart", "Low Prices")
    @link.organisation_id.should == 100
    @link.details.should == "Low Prices"
    @link.role.should == "Walmart"
    @link.project_id.should be_nil
    @link.contact_id.should be_nil
    @link.opportunity_id.should be_nil

  end
end
