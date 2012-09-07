module Insightly
	class Configuration

    def self.api_key
      ENV["INSIGHTLY_API_KEY"]
    end
	end
end
