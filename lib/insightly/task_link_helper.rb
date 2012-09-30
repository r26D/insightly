module Insightly
  module TaskLinkHelper
    def task_links
      @data["TASKLINKS"] ||= []
         @data["TASKLINKS"].collect {|a| Insightly::TaskLink.build(a)}
     end
     def task_links=(list)
       @data["TASKLINKS"] = list ? list.collect {|a| fix_for_link(a).remote_data} : []
     end
     def add_task_link(link)
       raise(ScriptError,"You must save the #{self.class} before adding a link.") if !remote_id
       @data["TASKLINKS"] ||= []
       @data["TASKLINKS"] << fix_for_link(link).remote_data
       true
     end
    def opportunity_ids
      self.task_links.collect { |task_link| task_link.opportunity_id}.compact
    end
    def opportunities
      self.opportunity_ids.collect { |id| Insightly::Opportunity.new(id)}
    end
    def add_opportunity_id(opportunity_id)
      return false if !opportunity_id
      self.save if !remote_id?
      add_task_link(Insightly::TaskLink.add_opportunity(opportunity_id))
      self.save
    end

    def add_opportunity(opportunity)
      opportunity.save if !opportunity.remote_id?
      add_opportunity_id(opportunity.remote_id)
    end
  end
end