module Insightly
  module LinkHelper
    def links
      @data["LINKS"] ||= []
         @data["LINKS"].collect {|a| Insightly::Link.build(a)}
     end
     def links=(list)
       @data["LINKS"] = list ? list.collect {|a| fix_for_link(a).remote_data} : []
     end
     def add_link(link)
       @data["LINKS"] ||= []
       @data["LINKS"] << fix_for_link(link).remote_data
       true
     end
  end
end