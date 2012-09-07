module Insightly
  class ReadOnly
    def initialize
      @data = {}

    end
    def url_base
      @url_base
    end

    def build(data)
      @data = data
      self
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
    def self.all
      item  = self.new
      list = []
      item.get_collection(item.url_base).each  do  |d|
         list << self.new.build(d)
      end
      list
    end


  end
end
