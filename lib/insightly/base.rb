#METODO only allow build to set fields that are part of the API fields
#METODO make a distinction between fields that you can set and save and ones you can only read - like DATE_UPDATED_UTC


module Insightly
  class Base
    @@api_fields = []

    def self.api_fields
      @@api_fields
    end

    def self.custom_fields(*args)

      args.each_with_index do |method, index|
        next if method.nil? or method == ""
        method_name = method.to_s.downcase.to_sym
        send :define_method, method_name do
          @data["#{self.class.const_get(:CUSTOM_FIELD_PREFIX)}_#{index+1}"]
        end
        method_name = "#{method.to_s.downcase}=".to_sym
        send :define_method, method_name do |value|
          @data["#{self.class.const_get(:CUSTOM_FIELD_PREFIX)}_#{index+1}"] = value
        end
      end
    end

    def self.api_field(*args)
      args.each do |field|
        @@api_fields << field
        method_name = field.downcase.to_sym
        send :define_method, method_name do
          @data[field]
        end
        method_name = "#{field.downcase}=".to_sym
        send :define_method, method_name do |value|
          @data[field] = value
        end
      end
    end

    def initialize(id = nil)
      @data = {}
      load(id) if id
    end

    def url_base
      self.class.const_get(:URL_BASE)
    end

    def remote_id
      raise ScriptError, "This should be overridden in the subclass"
    end

    def load(id)
      @data = get_collection("#{url_base}/#{id}")
      self
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
