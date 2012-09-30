#METODO add support for project
module Insightly
  module TaskLinkHelper
    def task_links
      @data["TASKLINKS"] ||= []
      @data["TASKLINKS"].collect { |a| Insightly::TaskLink.build(a) }
    end

    def task_links=(list)
      @data["TASKLINKS"] = list ? list.collect { |a| fix_for_link(a).remote_data } : []
    end

    def add_task_link(link)
      raise(ScriptError, "You must save the #{self.class} before adding a link.") if !remote_id
      @data["TASKLINKS"] ||= []
      @data["TASKLINKS"] << fix_for_link(link).remote_data
      true
    end
    def contact_ids
        list_ids_by_type("contact")
      end
  
      def contacts
        list_objs_by_type("contact", Insightly::Contact)
      end
  
      def add_contact_id(contact_id)
        add_by_id("contact", contact_id)
      end
  
      def add_contact(contact)
        add_by_obj("contact", contact)
      end
    
    
    
    def opportunity_ids
      list_ids_by_type("opportunity")
    end

    def opportunities
      list_objs_by_type("opportunity", Insightly::Opportunity)
    end

    def add_opportunity_id(opportunity_id)
      add_by_id("opportunity", opportunity_id)
    end

    def add_opportunity(opportunity)
      add_by_obj("opportunity", opportunity)
    end
    def organisation_ids
      list_ids_by_type("organisation")
    end

    def organisations
      list_objs_by_type("organisation", Insightly::Organisation)
    end

    def add_organisation_id(organisation_id)
      add_by_id("organisation", organisation_id)
    end

    def add_organisation(organisation)
      add_by_obj("organisation", organisation)
    end

    def list_ids_by_type(type)
      self.task_links.collect { |task_link| task_link.send("#{type}_id".to_sym) }.compact
    end

    def list_objs_by_type(type,klass)
      self.send("#{type}_ids".to_sym).collect { |id| klass.new(id) }
    end

    def add_by_id(type, id)
      return false if !id
         self.save if !remote_id?
         add_task_link(Insightly::TaskLink.send("add_#{type}".to_sym,id))
         self.save
    end

    def add_by_obj(type, obj)
      obj.save if !obj.remote_id?
      self.send("add_#{type}_id".to_sym, obj.remote_id)
    end
    protected :list_ids_by_type, :list_objs_by_type, :add_by_id, :add_by_obj
  end
end