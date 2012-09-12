require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Insightly::Organisation do
  before(:each) do
    Insightly::Configuration.api_key = INSIGHTLY_API_KEY

    @organisation = Insightly::Organisation.build(
        {
            "ORGANISATION_ID" => 4567891,
            "ORGANISATION_NAME" => "OrganisationTest.com",
            "BACKGROUND" => "Organisation Description",
            "ORGANISATION_FIELD_1" => "Organisation Field No 1",
            "ORGANISATION_FIELD_2" => "2011-10-28 12:00:00",
            "ORGANISATION_FIELD_3" => "f3frfrewq",
            "ORGANISATION_FIELD_4" => nil,
            "ORGANISATION_FIELD_5" => nil,
            "ORGANISATION_FIELD_6" => nil,
            "ORGANISATION_FIELD_7" => nil,
            "ORGANISATION_FIELD_8" => nil,
            "ORGANISATION_FIELD_9" => nil,
            "ORGANISATION_FIELD_10" => nil,
            "OWNER_USER_ID" => 12345,
            "DATE_CREATED_UTC" => "2011-07-15 02:20:00",
            "DATE_UPDATED_UTC" => "2011-10-10 08:51:19",
            "VISIBLE_TO" => "EVERYONE",
            "VISIBLE_TEAM_ID" => nil
        }

    )
    #  @task_links = Insightly::TaskLink.all
    #  d = 1
  end
  it " should have a url base " do
    Insightly::Organisation.new.url_base.should == "Organisations"
  end
  it " should know the organisation id " do
    @organisation.organisation_id.should == 4567891
  end
  it "should know the remote id " do
    @organisation.remote_id.should == @organisation.organisation_id
  end
  #it "should be able to create an organisation" do
  #  @organisation = Insightly::Organisation.new
  #
  #  @organisation.visible_to = "EVERYONE"
  #  @organisation.organisation_name = "000 Dummy Test Org"
  #  @organisation.background =  "This organisation was created for test purposes and can be deleted."
  #
  #  @organisation.save
  #
  #  @new_organisation = Insightly::Organisation.new(@organisation.remote_id)
  #  @new_organisation.organisation_name.should == @organisation.organisation_name
  #end
  context "addresses" do
    before(:each) do
      @org = Insightly::Organisation.new(8936117)
      @org.addresses = []
      @org.save

      @address = Insightly::Address.new
           @address.address_type = "Work"
           @address.street = "123 Main St"
           @address.city = "Indianpolis"
           @address.state = "IN"
           @address.postcode = "46112"
           @address.country = "US"
    end
    it "should allow you to update an address"   do
      @org.addresses.should == []
            @org.add_address(@address)

            @org.save
      @address.state = "TX"
      @org.addresses = [@address]
      @org.save
      @org.reload
      @org.addresses.length.should == 1
      @org.addresses.first.state.should == "TX"
    end
    it "should allow you to add an address" do


      @org.addresses.should == []
      @org.add_address(@address)

      @org.save
      @org.reload
      @org.addresses.length.should == 1
      @org.addresses.first.street.should == "123 Main St"
    end
    it "should allow you to remove an address"  do

      @org.addresses.should == []
      @org.add_address(@address)

      @org.save
      @org.addresses = []
      @org.save
      @org.reload
      @org.addresses.length.should == 0

    end
    it "should allow you to clear all addresses"    do
      @org.addresses.should == []
      @org.add_address(@address)

      @org.save
      @org.addresses = []
      @org.save
      @org.reload
      @org.addresses.length.should == 0
    end

    it "should not add an address if the same address is already on the organization"  do

      @org.addresses.should == []
           @org.add_address(@address)

           @org.add_address(@address)
      @org.addresses.length.should == 1
    end
  end
end