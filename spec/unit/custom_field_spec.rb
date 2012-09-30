require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")


describe Insightly::CustomField do
  before(:each) do
    Insightly::Configuration.api_key = INSIGHTLY_API_KEY
    Insightly::Configuration.logger = Insightly::Configuration._debug_logger


    @custom_field = Insightly::CustomField.build({
                                     "CUSTOM_FIELD_ID" => "OPPORTUNITY_FIELD_1",
                                     "FIELD_NAME" => "Type of Customer",
                                     "FIELD_HELP_TEXT" => "Are they a supplier or something else",
                                     "CUSTOM_FIELD_OPTIONS" => [],
                                     "ORDER_ID" => 1,
                                     "FIELD_TYPE" => "TEXT",
                                     "FIELD_FOR" => "OPPORTUNITY"
                                  })
    @custom_field2 = Insightly::CustomField.build({
                                     "CUSTOM_FIELD_ID" => "OPPORTUNITY_FIELD_1",
                                     "FIELD_NAME" => "Source of Customer",
                                     "FIELD_HELP_TEXT" => "How did they find us",
                                     "CUSTOM_FIELD_OPTIONS" => [{"OPTION_ID" => 1,
                                                                 "OPTION_VALUE" => "Magazine",
                                                                 "OPTION_DEFAULT" => true},
                                                                {"OPTION_ID" => 2,
                                                                "OPTION_VALUE" => "Web",
                                                                "OPTION_DEFAULT" => false}],
                                     "ORDER_ID" => 2,
                                     "FIELD_TYPE" => "DROPDOWN",
                                     "FIELD_FOR" => "OPPORTUNITY"
                                  })

    @all_custom_fields  = [@custom_field, @custom_field2]
  end
  it "should have a url base" do
    Insightly::CustomField.new.url_base.should == "CustomFields"

  end
  it "should get the custom_field id" do
    @custom_field.custom_field_id.should == "OPPORTUNITY_FIELD_1"
  end
  it "should have a remote id" do
    @custom_field.remote_id.should == @custom_field.custom_field_id
  end

end
