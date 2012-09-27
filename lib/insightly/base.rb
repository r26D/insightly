#METODO contacts allow you to set special dates to remember - can we access that via api?
#METODO It should have a method for converting date/time to the Insightly format
#METODO custom fields expect text,drop down, or date - add better handling (text should cast to_s)
#METODO contact infos should auto filter out duplicate entries
#METODO all the helpers should auto filter out duplicates (links,contact info,address etc)
#METODO only allow build to set fields that are part of the API fields
#METODO Fix all tests so they don't require the existence of certain object ids
#METODO add support for $top $skip and Brief=true for the things that suppor them
#METODO make a distinction between fields that you can set and save and ones you can only read - like DATE_UPDATED_UTC
module Insightly
  class Base

    class << self
      attr_accessor :api_fields,:url_base
    end
    self.api_fields = []


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
        self.api_fields = [] if !self.api_fields
        self.api_fields << field
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
      self.class.url_base
    end
    def remote_id
      raise ScriptError, "This should be overridden in the subclass"
    end

    def load(id)
      @data = get_collection("#{url_base}/#{id}")
      self
    end

    def reload
      load(remote_id)
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

    def remote_data
      @data
    end

    def process(result, content_type)
      if content_type == :json
        JSON.parse(result.to_str)
      elsif content_type == :xml
        Hash.from_xml(result.to_str)
      else
        result
      end
    end

    def config
      Insightly::Configuration.instantiate
    end

    def get_collection(path, content_selector = :json)
      if content_selector == :xml_raw
        content_type = :xml
      else
        content_type = content_selector
      end
      response = RestClient::Request.new(:method => :get,
                                         :url => "#{config.endpoint}/#{path.to_s}",
                                         :user => config.api_key,
                                         :password => "",
                                         :headers => {:accept => content_type, :content_type => content_type}).execute
      process(response, content_selector)
    end

    def self.all
      item = self.new
      list = []
      item.get_collection(item.url_base).each do |d|
        list << self.new.build(d)
      end
      list
    end


  end
end
