require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Insightly::Relationship do
  before(:each) do
    Insightly::Configuration.api_key = INSIGHTLY_API_KEY
    Insightly::Configuration.logger = Insightly::Configuration._debug_logger


    @relationship = Insightly::Relationship.build({"RELATIONSHIP_ID" => 1,
                                                  "FOR_ORGANISATIONS" => false,
                                                  "FOR_CONTACTS" => true,
                                                  "REVERSE" => "Colleague",
                                                  "FORWARD" => "Colleague",
                                                  "REVERSE_TITLE" => "is a colleague of",
                                                  "FORWARD_TITLE" => "is a colleague of"})
    @relationship2 = Insightly::Relationship.build({"RELATIONSHIP_ID" => 2,
                                                  "FOR_ORGANISATIONS" => true,
                                                  "FOR_CONTACTS" => false,
                                                  "REVERSE" => "is a supplier to",
                                                  "FORWARD" => "is a custoemr of",
                                                  "REVERSE_TITLE" => "Supplier",
                                                  "FORWARD_TITLE" => "Customer"})

    @all_relationships = [@relationship, @relationship2]
  end
  it "should have a url base" do
    Insightly::Relationship.new.url_base.should == "Relationships"
  end
  it "should be able to fetch all" do

      Insightly::Relationship.any_instance.stub(:get_collection).and_return(@all_relationships.collect { |x| x.remote_data })
      Insightly::Relationship.all.should == @all_relationships

  end
  it "should have be able to ask the relationship id" do
    @relationship.relationship_id.should == 1
  end
  it "should have a remote id" do
    @relationship.remote_id.should == @relationship.relationship_id
  end

end
