module Insightly
  class ContactInfo
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
    def contact_info_id
      @data["CONTACT_INFO_ID"]

    end
    def type
      @data["TYPE"]
    end
    def subtype
      @data["SUBTYPE"]
    end
    def label
      @data["LABEL"]
    end
    def detail
      @data["DETAIL"]
    end

    def contact_info_id=(value)
      @data["CONTACT_INFO_ID"] = value

    end
    def type=(value)
      @data["TYPE"] = value
    end
    def subtype=(value)
      @data["SUBTYPE"] = value
    end
    def label=(value)
      @data["LABEL"] = value
    end
    def detail=(value)
      @data["DETAIL"] = value
    end

  end
end