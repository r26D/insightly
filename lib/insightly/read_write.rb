module Insightly
  class ReadWrite < Base
    def to_json
      @data.to_json
    end
    def update_data(data)
      @data = data
    end
    def save
      if !remote_id
        update_data(post_collection("#{url_base}", self.to_json))
      else

        update_data(put_collection("#{url_base}/#{remote_id}", self.to_json))

      end

    end

    def post_collection(path, params, content_selector = :json)
      if content_selector == :xml_raw
        content_type = :xml
      else
        content_type = content_selector
      end

      begin
        url = "#{config.endpoint}/#{path.to_s}"

        response = RestClient::Request.new(:method => :post,
                                           :url => url,
                                           :user => config.api_key,
                                           :password => "",
                                           :payload => params,
                                           :headers => {:accept => content_type, :content_type => content_type}).execute

        process(response, content_selector)
      rescue => e
        puts "failure talking to Insight.ly #{url}"
        raise e
      end
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
