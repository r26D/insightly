require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Insightly::Configuration do
  it "should set the api key based on an env variable" do
    ENV["INSIGHTLY_API_KEY"] = "qwerty"
    Insightly::Configuration.api_key.should == "qwerty"
  end

end