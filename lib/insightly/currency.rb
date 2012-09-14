module Insightly
  class Currency < ReadOnly
    self.url_base = "Currencies"
    api_field "CURRENCY_CODE",
              "CURRENCY_SYMBOL"

    def build(data)
      if data.respond_to? :keys
        @data = data
      else
        @data = {"CURRENCY_CODE" => data, "CURRENCY_SYMBOL" => "$"}
      end
      self
    end
    def self.us
      self.build("USD")
    end
    def self.canada
      self.build("CAD")
    end

  end
end