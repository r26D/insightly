require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
#METODO Convert to VCR

describe Insightly::Contact do
  before(:each) do
    Insightly::Configuration.api_key = INSIGHTLY_API_KEY

    @contact = Insightly::Contact.build({"CONTACT_ID" => 1234567,
                                         "SALUTATION" => nil,
                                         "FIRST_NAME" => "John",
                                         "LAST_NAME" => "Doe",
                                         "BACKGROUND" => nil,
                                         "CONTACT_FIELD_1" => nil,
                                         "CONTACT_FIELD_2" => nil,
                                         "CONTACT_FIELD_3" => nil,
                                         "CONTACT_FIELD_4" => nil,
                                         "CONTACT_FIELD_5" => nil,
                                         "CONTACT_FIELD_6" => nil,
                                         "CONTACT_FIELD_7" => nil,
                                         "CONTACT_FIELD_8" => nil,
                                         "CONTACT_FIELD_9" => nil,
                                         "CONTACT_FIELD_10" => nil,
                                         "DATE_CREATED_UTC" => "2012-03-13 05:19:10",
                                         "DATE_UPDATED_UTC" => "2012-03-13 05:19:10",
                                         " ADDRESSES" => [],
                                         "CONTACTINFOS" => [{
                                                                "CONTACT_INFO_ID" => 7894561,
                                                                "TYPE" => "EMAIL",
                                                                "SUBTYPE" => nil,
                                                                "LABEL" => "Home",
                                                                "DETAIL" => "johndoe@insight.ly"
                                                            }],
                                         "VISIBLE_TO" => "EVERYONE",
                                         "VISIBLE_TEAM_ID" => nil
                                        })
    #  @task_links = Insightly::TaskLink.all
    #  d = 1
  end
  it "should have a url base" do
    Insightly::Contact.new.url_base.should == "Contacts"
  end
  it "should know the contact id" do

  end
  it " should know the contact id " do
    @contact.contact_id.should == 1234567
  end
  it "should know the remote id " do
    @contact.remote_id.should == @contact.contact_id
  end

# it "should be able to create an contact" do
#   @contact = Insightly::Contact.new
#
#   @contact.visible_to = "EVERYONE"
#   @contact.first_name = "000 Dummy"
#   @contact.last_name = "Test Contact"
#   @contact.background =  "This contact was created for test purposes and can be deleted."
#
#   @contact.save
#
#   @new_contact = Insightly::Contact.new(@contact.remote_id)
#   @new_contact.last_name.should == @contact.last_name
#end
  context "connections" do
    before(:each) do

      VCR.use_cassette('create connectable contact') do
        @contact = Insightly::Contact.new
        @contact.first_name = "00 Test"
        @contact.last_name = "Contact"
        @contact.visible_to = "Owner"


        @contact.contact_infos = []
        @contact.links = []
        @contact.tags = []
        @contact.addresses = []
        @contact.save
      end
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
      it "should allow you to update an address" do
        VCR.use_cassette('update address for contact') do
          @contact.addresses.should == []
          @contact.add_address(@address)

          @contact.save
          @address = @contact.addresses.first
          @address.state = "TX"
          @contact.addresses = [@address]
          @contact.addresses.length.should == 1

          @contact.save

          @contact.reload

          @contact.addresses.length.should == 1
          @contact.addresses.first.state.should == "TX"
        end

      end
      it "should allow you to add an address" do
        VCR.use_cassette('add address to contact') do

          @contact.addresses.should == []
          @contact.add_address(@address)

          @contact.save
          @contact.reload
          @contact.addresses.length.should == 1
          @contact.addresses.first.street.should == "123 Main St"
        end
      end
      it "should allow you to remove an address" do
        VCR.use_cassette('remove address from contact') do
          @contact.addresses.should == []
          @contact.add_address(@address)

          @contact.save
          @contact.addresses = []
          @contact.save
          @contact.reload
          @contact.addresses.length.should == 0
        end
      end
      it "should allow you to clear all addresses" do
        VCR.use_cassette('clear address from contact') do
          @contact.addresses.should == []
          @contact.add_address(@address)

          @contact.save
          @contact.addresses = []
          @contact.save
          @contact.reload
          @contact.addresses.length.should == 0
        end
      end

      it "should not add an address if the same address is already on the organization" do
        VCR.use_cassette('only add an addres once to a contact') do
          @contact.addresses.should == []
          @contact.add_address(@address)

          @contact.add_address(@address)
          @contact.addresses.length.should == 1
        end
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
      it "should allow you to update an contact_info" do
        @contact.contact_infos.should == []
        @contact.add_contact_info(@contact_info)

        @contact.save
        @contact_info.detail = "bobroberts@aol.com"
        @contact.contact_infos = [@contact_info]
        @contact.save
        @contact.reload
        @contact.contact_infos.length.should == 1
        @contact.contact_infos.first.detail.should == "bobroberts@aol.com"
      end
      it "should allow you to add an contact_info" do


        @contact.contact_infos.should == []
        @contact.add_contact_info(@contact_info)

        @contact.save
        @contact.reload
        @contact.contact_infos.length.should == 1
        @contact.contact_infos.first.detail.should == "bob@aol.com"
      end
      it "should allow you to remove an contact_info" do

        @contact.contact_infos.should == []
        @contact.add_contact_info(@contact_info)

        @contact.save
        @contact.contact_infos = []
        @contact.save
        @contact.reload
        @contact.contact_infos.length.should == 0

      end
      it "should allow you to clear all contact_infos" do
        @contact.contact_infos.should == []
        @contact.add_contact_info(@contact_info)

        @contact.save
        @contact.contact_infos = []
        @contact.save
        @contact.reload
        @contact.contact_infos.length.should == 0
      end
    end
    context "Links" do
      before(:each) do


        @link = Insightly::Link.add_organisation(8936117, "Employeer", "Handles payment")
        # @link = Insightly::Link.add_opportunity(968613,"Janitor", "Recent Hire")
      end
      it "should allow you to update an link" do
        @contact.links.should == []
        @contact.add_link(@link)

        @contact.save
        @link = @contact.links.first
        @link.details = "Old Veteran"
        @contact.links = [@link]
        @contact.save
        @contact.reload
        @contact.links.length.should == 1
        @contact.links.first.details.should == "Old Veteran"
      end
      it "should allow you to add an link" do


        @contact.links.should == []
        @contact.add_link(@link)
        @contact.add_link(@link)
        @contact.links.length.should == 2
        @contact.save
        @contact.reload
        @contact.links.length.should == 1
        @contact.links.first.details.should == "Handles payment"
      end
      it "should allow you to remove an link" do

        @contact.links.should == []
        @contact.add_link(@link)

        @contact.save
        @contact.links = []
        @contact.save
        @contact.reload
        @contact.links.length.should == 0

      end
      it "should allow you to clear all links" do
        @contact.links.should == []
        @contact.add_link(@link)

        @contact.save
        @contact.links = []
        @contact.save
        @contact.reload
        @contact.links.length.should == 0
      end
    end
    context "Tags" do
      before(:each) do

        @tag = Insightly::Tag.build("Paying Customer")
        @tag2 = Insightly::Tag.build("Freebie")

      end
      it "should allow you to update an tag" do
        @contact.tags.should == []
        @contact.add_tag(@tag)
        @tags = @contact.tags

        @contact.save
        @tag = @contact.tags.first
        @tag.tag_name = "Old Veteran"
        @contact.tags = [@tag]
        @contact.save
        @contact.reload
        @contact.tags.length.should == 1
        @contact.tags.first.tag_name.should == "Old Veteran"
      end
      it "should allow you to add an tag" do


        @contact.tags.should == []
        @contact.add_tag(@tag)
        @contact.add_tag(@tag)
        @contact.tags.length.should == 2
        @contact.save
        @contact.reload
        @contact.tags.length.should == 1
        @contact.tags.first.tag_name.should == "Paying Customer"
      end
      it "should allow you to remove an tag" do

        @contact.tags.should == []
        @contact.add_tag(@tag)

        @contact.save
        @contact.tags = []
        @contact.save
        @contact.reload
        @contact.tags.length.should == 0

      end
      it "should allow you to clear all tags" do
        @contact.tags.should == []
        @contact.add_tag(@tag)

        @contact.save
        @contact.tags = []
        @contact.save
        @contact.reload
        @contact.tags.length.should == 0
      end
    end
  end

end
