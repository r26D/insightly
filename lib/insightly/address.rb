module Insightly
  class Address < BaseData
    api_field "ADDRESS_ID",
              "ADDRESS_TYPE",
              "STREET",
              "CITY",
              "STATE",
              "POSTCODE",
              "COUNTRY"

    def same_address?(other)
      self.address_type == other.address_type &&
      self.street == other.street &&
          self.city == other.city &&
          self.state == other.state &&
          self.postcode == other.postcode &&
          self.country == other.country
    end
  end
end