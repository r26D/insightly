#METODO Find a way to link a task to an opportunity
#METODO link to a contact
#METODO link to an organization
module Insightly
  class Task < ReadWrite
    self.url_base = "Tasks"
    api_field "TASK_ID",
    "TITLE",
    "CATEGORY_ID",
    "DUE_DATE",
    "COMPLETED_DATE_UTC",
    "PUBLICLY_VISIBLE",
    "COMPLETED",
    "PROJECT_ID",
    "DETAILS",
    "STATUS",
    "PRIORITY",
    "PERCENT_COMPLETE",
    "START_DATE",
    "ASSIGNED_BY_USER_ID",
    "PARENT_TASK_ID",
    "RECURRENCE",
    "RESPONSIBLE_USER_ID",
    "OWNER_USER_ID",
    "DATE_CREATED_UTC",
    "DATE_UPDATED_UTC",
    "TASKLINKS"

    def comments
      list = []
      get_collection("#{url_base}/#{task_id}/comments").each do |d|
        list << Insightly::Comment.build(d)
      end
      list
    end
    def comment_on(body)
      comment = Insightly::Comment.new.build({ "BODY" => body})
      result = post_collection("#{url_base}/#{task_id}/comments", comment.remote_data.to_json)
      comment.build(result)
    end

    def not_started?
      status == "NOT STARTED"
    end

    def in_progress?
      status == "IN PROGRESS"
    end

    def waiting?
      status == "WAITING"
    end

    def completed?
      status == "COMPLETED"
    end

    def deferred?
      status == "DEFERRED"
    end


    def remote_id
      task_id
    end



  end
end