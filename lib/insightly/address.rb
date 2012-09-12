module Insightly
  class Address
    def initialize
      @data = {}
    end

    def to_json
      @data.to_json
    end
    def build(data)
      @data = data
      self
    end

    def self.build(data)
      self.new.build(data)
    end

    def ==(other)
      self.remote_data == other.remote_data
    end
    def same_address?(other)
      self.address_type == other.address_type &&
      self.street == other.street &&
          self.city == other.city &&
          self.state == other.state &&
          self.postcode == other.postcode &&
          self.country == other.country
    end
    def remote_data
      @data
    end
    def address_id
      @data["ADDRESS_ID"]

    end
    def address_type
      @data["ADDRESS_TYPE"]
    end
    def street
      @data["STREET"]
    end
    def city
      @data["CITY"]
    end
    def state
      @data["STATE"]
    end
    def postcode
      @data["POSTCODE"]

    end
    def country
      @data["COUNTRY"]
    end
    def address_id=(value)
      @data["ADDRESS_ID"] = value

    end
    def address_type=(value)
      @data["ADDRESS_TYPE"] = value
    end
    def street=(value)
      @data["STREET"] = value
    end
    def city=(value)
      @data["CITY"] = value
    end
    def state=(value)
      @data["STATE"] = value
    end
    def postcode=(value)
      @data["POSTCODE"] = value

    end
    def country=(value)
      @data["COUNTRY"] = value
    end
  end
end