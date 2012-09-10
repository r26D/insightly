module Insightly
  class TaskLink < ReadOnly
    self.url_base ="TaskLinks"

    def opportunity_id
      @data["OPPORTUNITY_ID"]
    end
    def task_id
      @data["TASK_ID"]
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