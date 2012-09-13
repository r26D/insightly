module Insightly
  class BaseData
    class << self
      attr_accessor :api_fields, :url_base
    end
    self.api_fields = []


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

    def remote_data
      @data
    end
  end
end
