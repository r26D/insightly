module Insightly
  class ContactInfo < BaseData
    api_field "CONTACT_INFO_ID",
              "TYPE",
              "SUBTYPE",
              "LABEL",
              "DETAIL"

    def self.phone(label, number)
      item = self.new
      item.type = "PHONE"
      item.label = label
      item.detail = number
      item
    end

    def self.email(label, email)
      item = self.new
      item.type = "EMAIL"
      item.label = label
      item.detail = email
      item
    end

    def self.social(label, info, subtype)
      item = self.new
      item.type = "SOCIAL"
      item.subtype = subtype
      item.label = label
      item.detail = info
      item
    end

    def self.website(label, url)
      item = self.new
      item.type = "WEBSITE"
      item.label = label
      item.detail = url
      item
    end

    def self.twitter_id(id)
      self.social("TwitterID", id, "TwitterID")
    end

    def self.linked_in(url)
      self.social("LinkedInPublicProfileUrl", url, "LinkedInPublicProfileUrl")
    end

    def self.work_phone(number)
      self.phone("Work", number)
    end

    def self.work_email(email)
      self.email("Work", email)
    end


    def self.business_website(url)
      self.website("Work", url)
    end

    def self.blog(url)
      self.website("Blog", url)
    end
  end
end