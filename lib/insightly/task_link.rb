module Insightly
  class TaskLink < ReadOnly
    self.url_base ="TaskLinks"
    api_field   "TASK_LINK_ID",
                "PROJECT_ID",
                "CONTACT_ID",
                "OPPORTUNITY_ID",
                "ORGANISATION_ID",
                "TASK_ID"

    def remote_id
      self.task_link_id
    end
    def self.search_by_opportunity_id(opportunity_id)
      list = []
      TaskLink.all.each do |x|
        if  !x.task_id.nil? && x.opportunity_id == opportunity_id
          list << x
        end
      end
      list
    end
  end
end