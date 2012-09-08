#This file is based heavily off of the Braintree::Configuration
#Copyright (c) 2009-2010 Braintree Payment Solutions

module Insightly
  class ConfigurationError < ::StandardError;
     def initialize(setting, message) # :nodoc:
       super "Insightly::Configuration.#{setting} #{message}"
     end
   end
  class Configuration
    API_VERSION = "v1" # :nodoc:
    DEFAULT_ENDPOINT = "https://api.insight.ly/v1" # :nodoc:

    class << self
      attr_writer :custom_user_agent, :endpoint, :logger, :api_key
    end
    attr_reader :endpoint, :custom_user_agent, :api_key

    def self.expectant_reader(*attributes) # :nodoc:
      attributes.each do |attribute|
        (class << self; self; end).send(:define_method, attribute) do
          attribute_value = instance_variable_get("@#{attribute}")
          raise ConfigurationError.new(attribute.to_s, "needs to be set") unless attribute_value
          attribute_value
        end
      end
    end
    expectant_reader :api_key

    def self.instantiate # :nodoc:
      config = new(
        :custom_user_agent => @custom_user_agent,
        :endpoint => @endpoint,
        :logger => logger,
        :api_key => api_key
      )
    end

    def self.custom_fields_for_opportunities(*args)
      Insightly::Opportunity.custom_fields(*args)
    end

    def self.logger
      @logger ||= _default_logger
    end

    def initialize(options = {})
      [:endpoint, :api_key, :custom_user_agent, :logger].each do |attr|
        instance_variable_set "@#{attr}", options[attr]
      end
    end

    def api_version # :nodoc:
      API_VERSION
    end

    def endpoint
      @endpoint || DEFAULT_ENDPOINT
    end

    def logger
      @logger ||= self.class._default_logger
    end

    def user_agent # :nodoc:
      base_user_agent = "Insightly Ruby Gem #{Insightly::Version::String}"
      @custom_user_agent ? "#{base_user_agent} (#{@custom_user_agent})" : base_user_agent
    end

    def self._default_logger # :nodoc:
      logger = Logger.new(STDOUT)
      logger.level = Logger::INFO
      logger
    end
    def self._debug_logger # :nodoc:
      logger = Logger.new(STDOUT)
      logger.level = Logger::DEBUG
      logger
    end
  end
end
