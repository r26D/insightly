module Insightly
  class Link < BaseData
    api_field "LINK_ID",
              "PROJECT_ID",
              "CONTACT_ID",
              "ROLE",
              "OPPORTUNITY_ID",
              "DETAILS",
              "ORGANISATION_ID"
    def self.add_contact(id,role = nil,detail = nil)
      item = Link.new
      item.contact_id = id
      item.role = role
      item.details = detail
      item
    end
    def self.add_opportunity(id,role = nil,detail = nil)
      item = Link.new
      item.opportunity_id = id
      item.role = role
      item.details = detail
      item
    end
    def self.add_organisation(id,role = nil,detail = nil)
      item = Link.new
      item.organisation_id = id
      item.role = role
      item.details = detail
      item
    end
  end
end
