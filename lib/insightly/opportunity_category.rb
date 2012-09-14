module Insightly
  class OpportunityCategory < ReadOnly
    self.url_base = "OpportunityCategories"
    api_field "CATEGORY_ID",
              "ACTIVE",
              "BACKGROUND_COLOR",
              "CATEGORY_NAME"

    def remote_id
      self.category_id
    end


  end
end