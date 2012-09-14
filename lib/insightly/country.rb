module Insightly
  class Country < ReadOnly
    self.url_base = "Countries"
    api_field "COUNTRY_NAME"

    def build(data)
      if data.respond_to? :keys
        @data = data
      else
        @data = {"COUNTRY_NAME" => data}
      end
      self
    end
    def self.us
      self.build("United States")
    end
    def self.canada
      self.build("Canada")
    end

  end
end