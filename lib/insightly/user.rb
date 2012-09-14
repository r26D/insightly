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
    def self.find_all_by_email(email)
      User.all.collect {|x| x if x.email_address && x.email_address.match(email)}.compact
    end
    def self.find_by_email(email)
      User.all.each do |x|
        return x if x.email_address && x.email_address.match(email)
      end
      nil
    end
    def self.find_all_by_name(name)
      User.all.collect {|x|  x if x.name && x.name.match(name) }.compact

    end
    def self.find_by_name(name)
      User.all.collect do |x|
        return x if x.name && x.name.match(name)
      end
      nil
    end
    def name
           "#{self.first_name} #{self.last_name}".strip
    end
    def last_name_first
      result = "#{self.last_name},#{self.first_name}".strip
      result == "," ? "" : result
    end
  end
end