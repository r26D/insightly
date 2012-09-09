module Insightly
  class ReadWrite < Base
    def save
      if !remote_id
        @data = post_collection("#{url_base}", @data.to_json)
      else

        @data = put_collection("#{url_base}/#{remote_id}", @data.to_json)

      end

    end

    def post_collection(path, params, content_selector = :json)
      if content_selector == :xml_raw
        content_type = :xml
      else
        content_type = content_selector
      end
      response = RestClient::Request.new(:method => :post,
                                         :url => "#{config.endpoint}/#{path.to_s}",
                                         :user => config.api_key,
                                         :password => "",
                                         :payload => params,
                                         :headers => {:accept => content_type, :content_type => content_type}).execute
      process(response, content_selector)
    end

    def put_collection(path, params, content_selector = :json)
      if content_selector == :xml_raw
        content_type = :xml
      else
        content_type = content_selector
      end
      response = RestClient::Request.new(:method => :put,
                                         :url => "#{config.endpoint}/#{path.to_s}",
                                         :user => config.api_key,
                                         :password => "",
                                         :payload => params,
                                         :headers => {:accept => content_type, :content_type => content_type}).execute
      process(response, content_selector)
    end
  end
end