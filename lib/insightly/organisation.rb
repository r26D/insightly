module Insightly
  class Organisation < ReadWrite
    include Insightly::AddressHelper
    include Insightly::ContactInfoHelper
    include Insightly::LinkHelper
    include Insightly::TagHelper

    self.url_base = "Organisations"
    CUSTOM_FIELD_PREFIX = "ORGANISATION_FIELD"
    api_field "ORGANISATION_ID",
              "ORGANISATION_NAME",
              "BACKGROUND",
              "ORGANISATION_FIELD_1",
              "ORGANISATION_FIELD_2",
              "ORGANISATION_FIELD_3",
              "ORGANISATION_FIELD_4",
              "ORGANISATION_FIELD_5",
              "ORGANISATION_FIELD_6",
              "ORGANISATION_FIELD_7",
              "ORGANISATION_FIELD_8",
              "ORGANISATION_FIELD_9",
              "ORGANISATION_FIELD_10",
              "OWNER_USER_ID",
              "DATE_CREATED_UTC",
              "DATE_UPDATED_UTC",
              "VISIBLE_TO",
              "VISIBLE_TEAM_ID"

    def initialize(id = nil)
      @data = {}
      @data["ADDRESSES"] = []
      load(id) if id
    end

    def remote_id
      organisation_id
    end

    def fix_for_link(link)
      #This needs to auto set the org id on the item
      link.organisation_id = self.remote_id
      link
    end

  end

end