module Insightly
  class User < ReadOnly
    self.url_base = "Users"
    api_field "DATE_UPDATED_UTC",
              "ACTIVE",
              "TIMEZONE_ID",
              "DATE_CREATED_UTC",
              "EMAIL_ADDRESS",
              "ACCOUNT_OWNER",
              "CONTACT_ID",
              "USER_ID",
              "ADMINISTRATOR",
              "LAST_NAME",
              "FIRST_NAME"

    def remote_id
      self.user_id
    end

    def self.find_by_email(email)
      User.all.collect.each do |x|
        x if x.email && x.email.match(email)
      end
    end

    def self.find_by_name(name)
      User.all.collect.each do |x|
        x if x.name && x.name.match(name)
      end
    end
    def name
      return "" if !self.first_name.nil? && !self.last_name.nil? && self.first.name.empty? && self.last_name.empty?
      "#{self.first_name} #{self.last_name}".strip
    end
    def last_name_first
      return "" if !self.first_name.nil? && !self.last_name.nil? && self.first.name.empty? && self.last_name.empty?
      "#{self.last_name} #{self.first_name}".strip
    end
  end
end