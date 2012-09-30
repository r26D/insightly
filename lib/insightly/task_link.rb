#METODO add support for project

module Insightly
  class TaskLink < ReadOnly
    self.url_base ="TaskLinks"
    api_field "TASK_LINK_ID",
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

    def self.add_contact(id)
      item = TaskLink.new
      item.contact_id = id
      item
    end

    def self.add_opportunity(id)
      item = TaskLink.new
      item.opportunity_id = id

      item
    end

    def self.add_organisation(id)
      item = TaskLink.new
      item.organisation_id = id
      item
    end
  end
end