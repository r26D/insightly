module Insightly
  module TaskLinkHelper
    def task_links
         @data["TASKLINKS"].collect {|a| Insightly::TaskLink.build(a)}
     end
     def task_links=(list)
       @data["TASKLINKS"] = list.collect {|a| fix_for_link(a).remote_data}
     end
     def add_task_link(link)
       @data["TASKLINKS"] << fix_for_link(link).remote_data
       true
     end
  end
end