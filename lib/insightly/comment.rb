module Insightly
  class Comment < Base
    URL_BASE = "Comments"

    api_field "COMMENT_ID",
              "BODY",
              "OWNER_USER_ID",
              "DATE_UPDATED_UTC",
              "DATE_CREATED_UTC",
              "FILE_ATTACHEMENTS"

    def remote_id
      comment_id
    end
    def load(id)
      result = get_collection("#{url_base}/#{id}", :xml)
      if result["Comment"]
        @data = result["Comment"]
        ["COMMENT_ID","OWNER_USER_ID"].each {|f| field_to_i(f)}
      end
      self
    end

    def save
      if remote_id
        @data = put_collection("#{url_base}/#{remote_id}", @data.to_xml, :xml)
      end

    end
    def field_to_i(field)
      @data[field] = @data[field].to_i  if  @data[field]
    end
  end
end
