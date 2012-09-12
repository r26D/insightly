require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Insightly::Address do
  before(:each) do
    Insightly::Configuration.api_key = INSIGHTLY_API_KEY
    @address = Insightly::Address.build({
          "ADDRESS_ID" => 1,
          "ADDRESS_TYPE" => "Work",
          "STREET" => "123 Main St.",
          "CITY" => "San Antonio",
          "STATE" => "TX",
          "POSTCODE" => "78216",
          "COUNTRY" => "US"
      })
  end
  it "should be able to build an address from data" do
    data = {
              "ADDRESS_ID" => 1,
              "ADDRESS_TYPE" => "Work",
              "STREET" => "123 Main St.",
              "CITY" => "San Antonio",
              "STATE" => "TX",
              "POSTCODE" => "78216",
              "COUNTRY" => "US"
          }
    @address = Insightly::Address.build(data)

    @address.remote_data.should == data
  end
  it "should be able to retrieve the data as an array" do
    @address.remote_data["ADDRESS_ID"].should == 1
  end
  it "should be able to convert to json" do
      @address.to_json.should == @address.remote_data.to_json
  end

  it "should know if two addresses are equal" do
    @address2 = Insightly::Address.build(@address.remote_data.clone)
    @address2.should == @address
    @address.country = nil
    @address2.should_not == @address
  end
  it "should know if it is the same address"  do
    @address2 = Insightly::Address.build(@address.remote_data.clone)
    @address2.should be_same_address(@address)
    @address2.address_id = 2
    @address2.should be_same_address(@address)
    @address.country = "UK"
    @address2.should_not be_same_address(@address)

  end
  it "should have accessor for address_id" do
    @address.address_id = 2
    @address.address_id.should == 2
  end
  it "should have an accessor for address type" do
    @address.address_type = "Home"
    @address.address_type.should == "Home"
  end
  it "should have an accessor for street" do
    @address.street = "432 Other St"
    @address.street.should == "432 Other St"
  end
  it "should have an accessor for city" do
    @address.city = "Miami"
    @address.city.should == "Miami"
  end
  it "should have an accessor for state" do
    @address.state = "FL"
    @address.state.should == "FL"
  end
  it "should have an accessor for postcode" do
    @address.postcode = 123456
    @address.postcode.should == 123456
  end
  it "should have an accessor for country"  do
    @address.country = "UK"
    @address.country.should == "UK"
  end

end