#METODO Fix the search by name
#METODO Fix status checking
#METODO fix the state change - so you can actually log a reason
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




    def open?
      state == "Open"
    end

    def lost?
      state == "Lost"
    end

    def won?
      state == "Won"
    end

    def lost!

    end

    def won!
      return if !opportunity_id
      state = "Won"
      save
    end

    def open!
      return if !opportunity_id
      state = "Open"
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