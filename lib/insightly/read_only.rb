module Insightly
  class ReadOnly < Base
    def initialize
      @data = {}

    end

    def url_base
      self.class.const_get(:URL_BASE)
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
    def remote_data
      @data
    end
    def process(result, content_type)
      puts result
      if content_type == :json
        JSON.parse(result.to_str)
      elsif content_type == :xml
        Hash.from_xml(result.to_str)
      else
        result.to_str
      end
    end

    def config
      Insightly::Configuration.instantiate
    end

    def get_collection(path, content_type = :json)
      response = RestClient::Request.new(:method => :get,
                                         :url => "#{config.endpoint}/#{path.to_s}",
                                         :user => config.api_key,
                                         :password => "",
                                         :headers => {:accept => content_type, :content_type => content_type}).execute
      process(response, content_type)
    end



  end
end
