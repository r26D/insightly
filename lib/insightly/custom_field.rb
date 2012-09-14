#METODO add better handling for CUSTOM_FIELD_OPTIONS
module Insightly
  class CustomField < ReadOnly
    self.url_base = "CustomFields"
    api_field  "CUSTOM_FIELD_ID",
               "FIELD_NAME",
               "FIELD_HELP_TEXT",
               "CUSTOM_FIELD_OPTIONS",
               "ORDER_ID",
               "FIELD_TYPE",
               "FIELD_FOR"
    def initialize(id = nil)
      @data = {"CUSTOM_FIELD_OPTIONS" = []}
      load(id) if id
    end
    def remote_id
      self.custom_field_id
    end

  end
end