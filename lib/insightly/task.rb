module Insightly
  class Task < Base

    def initialize(id = nil)
      @url_base = "Tasks"
      super
    end
    def comment_on(body)
      user_id = 226277
      xml_data = '<?xml version="1.0" encoding="utf-8"?><Comment xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><BODY>&lt;p&gt;&amp;nbsp;Hello Nurse&lt;/p&gt;</BODY><OWNER_USER_ID>226277</OWNER_USER_ID><FILE_ATTACHMENTS/></Comment>'


      post_collection("#{url_base}/#{task_id}/comments", xml_data, :xml)
    end

    def comments
      data = get_collection("#{url_base}/#{task_id}/Comments")
      list = []
      data.each do |x|
      end
      list
    end

    def status
      @data["STATUS"]
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

    def deferred
      status == "DEFERRED"
    end

    def task_id
      @data["TASK_ID"]
    end


    def save
      if !task_id
        @data = post_collection("#{url_base}", @data.to_json)
      else
        @data = put_collection("#{url_base}/#{task_id}", @data.to_json)
      end

    end


  end
end