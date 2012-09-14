module Insightly
  class Tag < ReadOnly
    self.url_base = "Tags"
    api_field "TAG_NAME"

    def build(data)
      if data.respond_to? :keys
        @data = data
      else
        @data = {"TAG_NAME" => data}
      end
      self
    end
    def self.contact_tags

      self.tags_by_type("Contacts")

    end
    def self.organisation_tags
      self.tags_by_type("Organisations")

    end
    def self.opportunity_tags
      self.tags_by_type("Opportunities")

    end
    def self.project_tags
      self.tags_by_type("Projects")
    end
    def self.email_tags
      self.tags_by_type("Emails")

    end
    def self.tags_by_type(type)
      item = self.new
      list = []
      item.get_collection("#{item.url_base}/#{type}").each do |d|
        list << self.new.build(d)
      end
      list
    end
  end

end