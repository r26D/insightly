#METODO Add support for FileAttachment xml
#METODO the load via xml and load via json do not return the same format data
module Insightly
  class Comment < ReadWrite
    self.url_base = "Comments"

    api_field "COMMENT_ID",
              "BODY",
              "OWNER_USER_ID",
              "DATE_UPDATED_UTC",
              "DATE_CREATED_UTC",
              "FILE_ATTACHMENTS"

    def remote_id
      comment_id
    end

    def load_from_xml(xml)
      result = Hash.from_xml(xml.to_str)
      if result["Comment"]
        @data = result["Comment"]
        ["COMMENT_ID", "OWNER_USER_ID"].each { |f| field_to_i(f) }
        @data.delete("xmlns:xsi")
        @data.delete('xmlns:xsd')
      end
      self
    end

    def to_xml
      <<-END_XML
<?xml version="1.0" encoding="utf-8"?>
        <Comment xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
        <COMMENT_ID>#{comment_id}</COMMENT_ID>
        <BODY>#{body}</BODY>
        <OWNER_USER_ID>#{owner_user_id}</OWNER_USER_ID>
        <DATE_CREATED_UTC>#{date_created_utc}</DATE_CREATED_UTC>
        <DATE_UPDATED_UTC>#{date_updated_utc}</DATE_UPDATED_UTC>
        <FILE_ATTACHMENTS></FILE_ATTACHMENTS>
        </Comment>
      END_XML
    end

    def load(id)
      load_from_xml(get_collection("#{url_base}/#{id}", :xml_raw))
    end

    def save
      put_collection("#{url_base}", to_xml, :xml_raw)
      self
    end

    def field_to_i(field)
      @data[field] = @data[field].to_i if  @data[field]
    end
  end
end
