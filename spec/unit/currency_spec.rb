require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Insightly::Currency do
  before(:each) do
    Insightly::Configuration.api_key = INSIGHTLY_API_KEY
    Insightly::Configuration.logger = Insightly::Configuration._debug_logger
    @currency = Insightly::Currency.build({"CURRENCY_CODE" => "USD", "CURRENCY_SYMBOL" => "$"})
    @currency2 = Insightly::Currency.build({"CURRENCY_CODE" => "CAD", "CURRENCY_SYMBOL" => "$"})

    @all_currencies = [@currency, @currency2]
  end
  it "should have a url base" do
    Insightly::Currency.new.url_base.should == "Currencies"
  end
  it "should be able to fetch all of the currencies" do

      Insightly::Country.any_instance.stub(:get_collection).and_return(@all_currencies.collect { |x| x.remote_data })
      Insightly::Country.all.should == @all_currencies

  end
  it "should allow you to build a currency from a string" do
    @currency = Insightly::Currency.build("USD")
    @currency.currency_code.should == "USD"
    @currency.currency_symbol.should == "$"
    @currency.remote_data.should == {"CURRENCY_CODE" => "USD", "CURRENCY_SYMBOL" => "$" }
  end
  it "should be able to retrieve the data as an array" do
    @currency.remote_data["CURRENCY_CODE"].should == "USD"
  end
  it "should be able to convert to json" do
      @currency.to_json.should == @currency.remote_data.to_json
  end

  it "should know if two currencies are equal" do
    @currency2 = Insightly::Currency.build(@currency.remote_data.clone)
    @currency2.should == @currency
    @currency.currency_code = "Bob"
    @currency2.should_not == @currency
  end

  it "should have accessor for currency_code" do
    @currency.currency_code = "Will"
    @currency.currency_code.should == "Will"
  end
  it "should have a US standard object" do
    Insightly::Currency.us.currency_code.should == "USD"
    Insightly::Currency.us.currency_symbol.should == "$"
  end
  it "should have a Canada standard object" do
    Insightly::Currency.canada.currency_code.should == "CAD"
    Insightly::Currency.canada.currency_symbol.should == "$"
  end
end
