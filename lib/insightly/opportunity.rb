module Insightly
  class Opportunity < Base
    URL_BASE = "Opportunities"
    CUSTOM_FIELD_PREFIX = "OPPORTUNITY_FIELD"
    api_field "OPPORTUNITY_FIELD_10",
              "OPPORTUNITY_FIELD_9",
              "OPPORTUNITY_FIELD_8",
              "OPPORTUNITY_FIELD_7",
              "OPPORTUNITY_FIELD_6",
              "OPPORTUNITY_FIELD_5",
              "OPPORTUNITY_FIELD_4",
              "OPPORTUNITY_FIELD_3",
              "OPPORTUNITY_FIELD_2",
              "OPPORTUNITY_FIELD_1",
              "VISIBLE_TO",
              "BID_TYPE",
              "ACTUAL_CLOSE_DATE",
              "DATE_UPDATED_UTC",
              "OWNER_USER_ID",
              "BID_DURATION",
              "BID_CURRENTY",
              "PIPELINE_ID",
              "CATEGORY_ID",
              "PROBABILITY",
              "TAGS",
              "IMAGE_URL",
              "BID_AMOUNT",
              "VISIBLE_TEAM_ID",
              "STAGE_ID",
              "DATE_CREATED_UTC",
              "OPPORTUNITY_STATE",
              "FORECAST_CLOSE_DATE",
              "OPPORTUNITY_NAME",
              "OPPORTUNITY_ID",
              "VISIBLE_USER_IDS",
              "LINKS",
              "RESPONSIBLE_USER_ID",
              "OPPORTUNITY_DETAILS"

    def initialize(id = nil)

      super
    end

    def remote_id
      opportunity_id
    end

    def tasks
      list = []
      Insightly::TaskLink.search_by_opportunity_id(opportunity_id).each do |x|
        list << Insightly::Task.new(x.task_id)
      end
      list
    end

    def opportunity_id
      @data["OPPORTUNITY_ID"]
    end


    def contact_name
      @data["OPPORTUNITY_FIELD_8"]
    end

    def contact_name=(value)
      @data["OPPORTUNITY_FIELD_8"] = value
    end

    def company_name
      @data["OPPORTUNITY_FIELD_7"]
    end

    def company_name=(value)
      @data["OPPORTUNITY_FIELD_7"] = value
    end

    def organization
      @data["OPPORTUNITY_FIELD_6"]
    end

    def organization=(value)
      @data["OPPORTUNITY_FIELD_6"] = value
    end

    def plan
      @data["OPPORTUNITY_FIELD_5"]
    end

    def plan=(value)
      @data["OPPORTUNITY_FIELD_5"] = value
    end

    def timezone
      @data["OPPORTUNITY_FIELD_4"]
    end

    def timezone=(value)
      @data["OPPORTUNITY_FIELD_4"] = value
    end

    def phone_number
      @data["OPPROTUNITY_FIELD_3"]
    end

    def phone_number=(value)
      @data["OPPORTUNITY_FIELD_3"] = value
    end

    def admin_url
      @data["OPPORTUNITY_FIELD_2"]
    end

    def admin_url=(value)
      @data["OPPORTUNITY_FIELD_2"] = value
    end


    def open?
      @data["OPPORTUNITY_STATE"] == "Open"
    end

    def lost?
      @data["OPPORTUNITY_STATE"] == "Lost"
    end

    def won?
      @data["OPPORTUNITY_STATE"] == "Won"
    end

    def lost!

    end

    def won!
      return if !opportunity_id
      @data["OPPORTUNITY_STATE"] = "Won"
      save
    end

    def open!
      return if !opportunity_id
      @data["OPPORTUNITY_STATE"] = "Open"
      save
    end

    def self.search_by_name(name)
      data = Insightly::get_collection(@@url_base)
      list = []
      data.each do |x|
        if x["OPPORTUNITY_NAME"].match(name)
          list << Insightly::Opportunity.new.build(x)
        end
      end
      list
    end

  end
end