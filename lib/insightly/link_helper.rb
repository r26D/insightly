#METODO be able to ask the object for a list of project_ids and projects
module Insightly
  module LinkHelper
    def links
      @data["LINKS"] ||= []
      @data["LINKS"].collect { |a| Insightly::Link.build(a) }
    end

    def links=(list)
      @data["LINKS"] = list ? list.collect { |a| fix_for_link(a).remote_data } : []
    end

    def add_link(link)
      @data["LINKS"] ||= []
      @data["LINKS"] << fix_for_link(link).remote_data
      true
    end
    def contact_ids
      self.links.collect { |link| link.contact_id}.compact
    end
    def opportunity_ids
      self.links.collect { |link| link.contact_id}.compact
    end
    def organisation_ids
      self.links.collect { |link| link.organisation_id}.compact
    end
    def contacts
      self.contact_ids.collect { |id| Insightly::Contact.new(id)}
    end
    def opportunities
      self.opportunity_ids.collect { |id| Insightly::Opportunity.new(id)}
    end
    def organisations
      self.organisation_ids.collect { |id| Insightly::Organisation.new(id)}
    end
    #def project_ids
    #    self.links.collect { |link| link.project_id}.compact
    #end
    #def projects
    #  self.project_ids.collect { |id| Insightly::Project.new(id)}
    #end
  end
end