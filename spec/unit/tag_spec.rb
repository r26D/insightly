require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Insightly::Tag do
  before(:each) do
    Insightly::Configuration.api_key = INSIGHTLY_API_KEY
    @tag = Insightly::Tag.build({
          "TAG_NAME" => "Happy"
      })
  end
  it "should be able to build an tag from data" do
    data = {
        "TAG_NAME" => "Happy"
    
          }
    @tag = Insightly::Tag.build(data)

    @tag.remote_data.should == data
  end
  it "should allow you to build a tag from a string" do
    @tag = Insightly::Tag.build("Happy")
    @tag.tag_name.should == "Happy"
    @tag.remote_data.should == {"TAG_NAME" => "Happy"}
  end
  it "should be able to retrieve the data as an array" do
    @tag.remote_data["TAG_NAME"].should == "Happy"
  end
  it "should be able to convert to json" do
      @tag.to_json.should == @tag.remote_data.to_json
  end

  it "should know if two tages are equal" do
    @tag2 = Insightly::Tag.build(@tag.remote_data.clone)
    @tag2.should == @tag
    @tag.tag_name = "Bob"
    @tag2.should_not == @tag
  end

  it "should have accessor for tag_name" do
    @tag.tag_name = "Will"
    @tag.tag_name.should == "Will"
  end
end