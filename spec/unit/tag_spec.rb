require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Insightly::Tag do
  before(:each) do
    Insightly::Configuration.api_key = INSIGHTLY_API_KEY
    @tag = Insightly::Tag.build({
          "TAG_NAME" => "Happy"
      })
    @tag2 = Insightly::Tag.build({
          "TAG_NAME" => "Happy"
      })
    @all_tags = [@tag, @tag2]
  end
  it "should be able to build an tag from data" do
    data = {
        "TAG_NAME" => "Happy"
    
          }
    @tag = Insightly::Tag.build(data)

    @tag.remote_data.should == data
  end
  it "should be able to fetch all tags" do
    Insightly::Tag.any_instance.stub(:get_collection).and_return(@all_tags.collect { |x| x.remote_data })
    Insightly::Tag.all.should == @all_tags
  end
  it "should allow you to see tags by contact" do
    Insightly::Tag.any_instance.stub(:get_collection).with("#{@tag.url_base}/Contacts").and_return([@tag.remote_data])
    Insightly::Tag.contact_tags.should == [@tag]
  end
  it "should allow you to see tags by organisations" do
    Insightly::Tag.any_instance.stub(:get_collection).with("#{@tag.url_base}/Organisations").and_return([@tag.remote_data])
    Insightly::Tag.contact_tags.should == [@tag]
  end
  it "should allow you to see tags by opportunites" do
    Insightly::Tag.any_instance.stub(:get_collection).with("#{@tag.url_base}/Opportunities").and_return([@tag.remote_data])
    Insightly::Tag.contact_tags.should == [@tag]
  end
  it "should allow you to see tags by projects" do
    Insightly::Tag.any_instance.stub(:get_collection).with("#{@tag.url_base}/Projects").and_return([@tag.remote_data])
    Insightly::Tag.contact_tags.should == [@tag]
  end
  it "should allow you to see tags by emails" do
    Insightly::Tag.any_instance.stub(:get_collection).with("#{@tag.url_base}/Emails").and_return([@tag.remote_data])
    Insightly::Tag.contact_tags.should == [@tag]
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