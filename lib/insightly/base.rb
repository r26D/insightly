module Insightly
  class Base
    def initialize(id = nil)
      @data = {}
      load(id) if id
    end
    def url_base
      @url_base
    end
    def remote_id
      raise ScriptError, "This should be overridden in the subclass"
    end
    def load(id)
      @data = get_collection("#{url_base}/#{id}")
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

    def post_collection(path, params, content_type = :json)
      response = RestClient::Request.new(:method => :post,
                                         :url => "#{config.endpoint}/#{path.to_s}",
                                         :user => config.api_key,
                                         :password => "",
                                         :payload => params,
                                         :headers => {:accept => content_type, :content_type => content_type}).execute
      process(response, content_type)
    end

    def put_collection(path, params, content_type = :json)
      response = RestClient::Request.new(:method => :put,
                                         :url => "#{config.endpoint}/#{path.to_s}",
                                         :user => config.api_key,
                                         :password => "",
                                         :payload => params,
                                         :headers => {:accept => content_type, :content_type => content_type}).execute
      process(response, content_type)
    end
    def save
      if !remote_id
        @data = post_collection("#{url_base}", @data.to_json)
      else
        @data = put_collection("#{url_base}/#{remote_id}", @data.to_json)
      end

    end

  end
end
