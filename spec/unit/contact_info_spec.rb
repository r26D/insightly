require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
#METODO Convert to VCR

describe Insightly::ContactInfo do
  before(:each) do
    Insightly::Configuration.api_key = INSIGHTLY_API_KEY

  #  @all = Insightly::Contact.new(20315449)
    @contact_info = Insightly::ContactInfo.build({
         "LABEL" => "Work",
         "SUBTYPE" => nil,
         "CONTACT_INFO_ID" => 1,
         "TYPE" => "WEBSITE",
         "DETAIL" => "http://www.truckingoffice.com"

      })
  end
  it "should be able to build an contact_info from data" do
    data = {
             "LABEL" => "Work",
             "SUBTYPE" => nil,
             "CONTACT_INFO_ID" => 1,
             "TYPE" => "WEBSITE",
             "DETAIL" => "http://www.truckingoffice.com"

     }
    @contact_info = Insightly::ContactInfo.build(data)

    @contact_info.remote_data.should == data
  end
  it "should be able to retrieve the data as an array" do
    @contact_info.remote_data["CONTACT_INFO_ID"].should == 1
  end
  it "should be able to convert to json" do
      @contact_info.to_json.should == @contact_info.remote_data.to_json
  end

  it "should know if two contact_info are equal" do
    @contact_info2 = Insightly::ContactInfo.build(@contact_info.remote_data.clone)
    @contact_info2.should == @contact_info
    @contact_info.detail = nil
    @contact_info2.should_not == @contact_info
  end

  it "should have accessor for contact_info_id" do
    @contact_info.contact_info_id = 2
    @contact_info.contact_info_id.should == 2
  end
  it "should have accessor for type" do
    @contact_info.type = 2
    @contact_info.type.should == 2
  end
  it "should have accessor for subtype" do
    @contact_info.subtype = 2
    @contact_info.subtype.should == 2
  end

  it "should have accessor for label" do
    @contact_info.label = "Worker"
    @contact_info.label.should == "Worker"
  end
  it "should have accessor for detail" do
    @contact_info.detail = "New hire"
    @contact_info.detail.should == "New hire"
  end

 it "should be easy to add a phone number" do
    @info = Insightly::ContactInfo.phone("Work","210-555-1212")
   @info.label.should == "Work"
   @info.subtype.should be_nil
   @info.detail.should == "210-555-1212"
   @info.type.should == "PHONE"
 end
  it "should be easy to add a work phone number" do
      @info = Insightly::ContactInfo.work_phone("210-555-1212")
     @info.label.should == "Work"
     @info.subtype.should be_nil
     @info.detail.should == "210-555-1212"
     @info.type.should == "PHONE"
   end
  it "should be easy to add an email" do
      @info = Insightly::ContactInfo.email("Work","bob@aol.com")
     @info.label.should == "Work"
     @info.subtype.should be_nil
     @info.detail.should == "bob@aol.com"
     @info.type.should == "EMAIL"
   end
  it "should be easy to add a work email" do
      @info = Insightly::ContactInfo.work_email("bob@aol.com")
     @info.label.should == "Work"
     @info.subtype.should be_nil
     @info.detail.should == "bob@aol.com"
     @info.type.should == "EMAIL"
   end
  it "should be easy to add a website" do
      @info = Insightly::ContactInfo.website("Work","http://www.truckingoffice.com")
     @info.label.should == "Work"
     @info.subtype.should be_nil
     @info.detail.should == "http://www.truckingoffice.com"
     @info.type.should == "WEBSITE"
   end
  it "should be easy to add a business website" do
      @info = Insightly::ContactInfo.business_website("http://www.truckingoffice.com")
     @info.label.should == "Work"
     @info.subtype.should be_nil
     @info.detail.should == "http://www.truckingoffice.com"
     @info.type.should == "WEBSITE"
   end
  it "should be easy to add a blog"   do
      @info = Insightly::ContactInfo.blog("http://www.r26d.com")
     @info.label.should == "Blog"
     @info.subtype.should be_nil
     @info.detail.should == "http://www.r26d.com"
     @info.type.should == "WEBSITE"
   end
  it "should be easy to add a twitter id" do
      @info = Insightly::ContactInfo.twitter_id("economysizegeek")
     @info.label.should == "TwitterID"
     @info.subtype.should == "TwitterID"
     @info.detail.should == "economysizegeek"
     @info.type.should == "SOCIAL"
   end
  it "should be easy to add a social entry"  do
      @info = Insightly::ContactInfo.social('TwitterID','economysizegeek','TwitterID')
     @info.label.should == "TwitterID"
     @info.subtype.should == "TwitterID"
     @info.detail.should == "economysizegeek"
     @info.type.should == "SOCIAL"
   end
  it "should be easy to add a linked in profile"  do
      @info = Insightly::ContactInfo.linked_in("http://www.linkedin.com/company/1499784")
     @info.label.should == "LinkedInPublicProfileUrl"
     @info.subtype.should == "LinkedInPublicProfileUrl"
     @info.detail.should == "http://www.linkedin.com/company/1499784"
     @info.type.should == "SOCIAL"
   end


end
