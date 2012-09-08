#METODO Find a way to link a task to an opportunity
#METODO Add support for adding a comment to a task
module Insightly
  class Task < Base
    URL_BASE = "Tasks"

    #def comment_on(body)
    #  user_id = 226277
    #  xml_data = '<?xml version="1.0" encoding="utf-8"?><Comment xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><BODY>&lt;p&gt;&amp;nbsp;Hello Nurse&lt;/p&gt;</BODY><OWNER_USER_ID>226277</OWNER_USER_ID><FILE_ATTACHMENTS/></Comment>'
    #
    #
    #  post_collection("#{url_base}/#{task_id}/comments", xml_data, :xml)
    #end
    #
    #def comments
    #  data = get_collection("#{url_base}/#{task_id}/Comments")
    #  list = []
    #  data.each do |x|
    #  end
    #  list
    #end

    def status
      @data["STATUS"]
    end
    def status=(new_status)
      @data["STATUS"] = new_status
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

    def task_id
      @data["TASK_ID"]
    end

    def remote_id
      task_id
    end



  end
end