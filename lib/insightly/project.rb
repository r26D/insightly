module Insightly
  class Project < Base
    self.url_base = "Projects"    
    api_field "PROJECT_ID",
      "PROJECT_NAME",
      "STATUS",
      "PROJECT_DETAILS",
      "OPPORTUNITY_ID",
      "STARTED_DATE",
      "COMPLETED_DATE", 
      "PROJECT_FIELD_1", 
      "RESPONSIBLE_USER_ID", 
      "OWNER_USER_ID", 
      "DATE_CREATED_UTC",
      "DATE_UPDATED_UTC", 
      "CATEGORY_ID",
      "PIPELINE_ID",
      "STAGE_ID", 
      "VISIBLE_TO",
      "VISIBLE_TEAM_ID"
   end
end
