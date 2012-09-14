module Insightly
  class TaskCategory < ReadOnly
    self.url_base = "TaskCategories"
    api_field "CATEGORY_ID",
              "ACTIVE",
              "BACKGROUND_COLOR",
              "CATEGORY_NAME"

    def remote_id
      self.category_id
    end


  end
end