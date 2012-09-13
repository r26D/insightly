module Insightly
  class Opportunity < ReadWrite
    include Insightly::LinkHelper
    self.url_base = "Opportunities"
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
              "BID_CURRENCY",
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


    OpportunityStateReason::STATES.each do |s|

      self.instance_eval do
        define_method "#{s.downcase}?".to_sym do
          self.opportunity_state == s
        end

        define_method "#{s.downcase}!".to_sym do |*args|
          reason = args.first
          @state_reason = nil
          if reason
            @state_reason = Insightly::OpportunityStateReason.find_by_state_reason(s, reason)
          end

          if @state_reason
            put_collection("OpportunityStateChange/#{opportunity_id}", @state_reason.remote_data.to_json)
            reload
          else
            #Changing state without a reason/log entry

            self.opportunity_state = s
            save
          end
        end
      end

    end

    def self.find_by_name(name)
      Insightly::Opportunity.all.each do |o|
        return o if o.opportunity_name && o.opportunity_name == name
      end
      nil
    end

    def self.search_by_name(name)
      list = []
      Insightly::Opportunity.all.each do |o|
        if o.opportunity_name && o.opportunity_name.match(name)
          list << o
        end
      end
      list
    end

    def save
      creating = remote_id ? false : true

      super
      if creating
        @state_reason = Insightly::OpportunityStateReason.find_by_state_reason("Open", "Created by API")

        if @state_reason
          put_collection("OpportunityStateChange/#{opportunity_id}", @state_reason.remote_data.to_json)
        end
      end

    end
    def fix_for_link(link)
       #This needs to auto set the org id on the item
       link.opportunity_id = self.remote_id
       link
     end
  end

end