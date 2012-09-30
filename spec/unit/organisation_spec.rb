require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
#METODO Convert to VCR

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

  end
  context "remote id" do
      it "should know if the remote id is set" do
        @organisation.remote_id = nil
        @organisation.remote_id?.should be_false
        @organisation.remote_id = ""
        @organisation.remote_id?.should be_false
        @organisation.remote_id = 1
        @organisation.remote_id?.should be_true
        @organisation.remote_id = "1"
        @organisation.remote_id?.should be_true
      end
      it "should know that the remote id and the organisation id are the same" do
        @organisation.remote_id.should == @organisation.organisation_id
      end
      it "should allow you to set the remote id" do
        @organisation.remote_id = 12
        @organisation.organisation_id.should == 12
      end
      it "should know the correct remote field" do
        @organisation.remote_id_field.should == "organisation_id"
      end
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
  #  @organisation.background =  "This organisation was crtaskeated for test purposes and can be deleted."
  #
  #  @organisation.save
  #
  #  @new_organisation = Insightly::Organisation.new(@organisation.remote_id)
  #  @new_organisation.organisation_name.should == @organisation.organisation_name
  #end
  context "connections" do
    before(:each) do


      @org = Insightly::Organisation.new(8936117)
      @org.addresses = []
      @org.tags = []
      @org.links = []
      @org.contact_infos = []
      @org.save
    end

    context "addresses" do
      before(:each) do


        @address = Insightly::Address.new
        @address.address_type = "Work"
        @address.street = "123 Main St"
        @address.city = "Indianpolis"
        @address.state = "IN"
        @address.postcode = "46112"
        @address.country = "US"
      end
      it "should let you set it to nil" do
        @org.addresses = nil
        @org.addresses.should == []
      end
      it "should allow you to update an address" do
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
      it "should allow you to remove an address" do

        @org.addresses.should == []
        @org.add_address(@address)

        @org.save
        @org.addresses = []
        @org.save
        @org.reload
        @org.addresses.length.should == 0

      end
      it "should allow you to clear all addresses" do
        @org.addresses.should == []
        @org.add_address(@address)

        @org.save
        @org.addresses = []
        @org.save
        @org.reload
        @org.addresses.length.should == 0
      end

      it "should not add an address if the same address is already on the organization" do

        @org.addresses.should == []
        @org.add_address(@address)

        @org.add_address(@address)
        @org.addresses.length.should == 1
      end
    end

    context "contact_infos" do
      before(:each) do


        @contact_info = Insightly::ContactInfo.new
        @contact_info.type = "PHONE"
        @contact_info.label = "Work"
        @contact_info.subtype = nil
        @contact_info.detail = "bob@aol.com"

      end
      it "should let you set it to nil" do
         @org.contact_infos = nil
         @org.contact_infos.should == []
       end
      it "should allow you to update an contact_info" do
        @org.contact_infos.should == []
        @org.add_contact_info(@contact_info)

        @org.save
        @contact_info.detail = "bobroberts@aol.com"
        @org.contact_infos = [@contact_info]
        @org.save
        @org.reload
        @org.contact_infos.length.should == 1
        @org.contact_infos.first.detail.should == "bobroberts@aol.com"
      end
      it "should allow you to add an contact_info" do


        @org.contact_infos.should == []
        @org.add_contact_info(@contact_info)

        @org.save
        @org.reload
        @org.contact_infos.length.should == 1
        @org.contact_infos.first.detail.should == "bob@aol.com"
      end
      it "should allow you to remove an contact_info" do

        @org.contact_infos.should == []
        @org.add_contact_info(@contact_info)

        @org.save
        @org.contact_infos = []
        @org.save
        @org.reload
        @org.contact_infos.length.should == 0

      end
      it "should allow you to clear all contact_infos" do
        @org.contact_infos.should == []
        @org.add_contact_info(@contact_info)

        @org.save
        @org.contact_infos = []
        @org.save
        @org.reload
        @org.contact_infos.length.should == 0
      end
    end
    context "Links" do
      before(:each) do


        @link = Insightly::Link.add_contact(2982194, "Janitor", "Recent Hire")
        # @link = Insightly::Link.add_opportunity(968613,"Janitor", "Recent Hire")
      end
      it "should provide a list of contact_ids"
      it "should provide a list of opportunity_ids"
      it "should provide a list of organisation_ids"
      it "should provide a list of contacts"
      it "should provide a list of opportunities"
      it "should provide a list of organisations"
      it "should let you set it to nil" do
         @org.links = nil
         @org.links.should == []
       end
      it "should allow you to update an link" do
        @org.links.should == []
        @org.add_link(@link)

        @org.save
        @link = @org.links.first
        @link.details = "Old Veteran"
        @org.links = [@link]
        @org.save
        @org.reload
        @org.links.length.should == 1
        @org.links.first.details.should == "Old Veteran"
      end
      it "should allow you to add an link" do


        @org.links.should == []
        @org.add_link(@link)

        @org.save
        @org.reload
        @org.links.length.should == 1
        @org.links.first.details.should == "Recent Hire"
      end
      it "should allow you to remove an link" do

        @org.links.should == []
        @org.add_link(@link)

        @org.save
        @org.links = []
        @org.save
        @org.reload
        @org.links.length.should == 0

      end
      it "should allow you to clear all links" do
        @org.links.should == []
        @org.add_link(@link)

        @org.save
        @org.links = []
        @org.save
        @org.reload
        @org.links.length.should == 0
      end
    end
    context "Tags" do
      before(:each) do

        @tag = Insightly::Tag.build("Paying Customer")
        @tag2 = Insightly::Tag.build("Freebie")

      end
      it "should let you set it to nil" do
         @org.tags = nil
         @org.tags.should == []
       end
      it "should allow you to update an tag" do
        @org.tags.should == []
        @org.add_tag(@tag)
        @tags = @org.tags

        @org.save
        @tag = @org.tags.first
        @tag.tag_name = "Old Veteran"
        @org.tags = [@tag]
        @org.save
        @org.reload
        @org.tags.length.should == 1
        @org.tags.first.tag_name.should == "Old Veteran"
      end
      it "should allow you to add an tag" do


        @org.tags.should == []
        @org.add_tag(@tag)
        @org.add_tag(@tag)
        @org.tags.length.should == 2
        @org.save
        @org.reload
        @org.tags.length.should == 1
        @org.tags.first.tag_name.should == "Paying Customer"
      end
      it "should allow you to remove an tag" do

        @org.tags.should == []
        @org.add_tag(@tag)

        @org.save
        @org.tags = []
        @org.save
        @org.reload
        @org.tags.length.should == 0

      end
      it "should allow you to clear all tags" do
        @org.tags.should == []
        @org.add_tag(@tag)

        @org.save
        @org.tags = []
        @org.save
        @org.reload
        @org.tags.length.should == 0
      end
    end
  end
end
