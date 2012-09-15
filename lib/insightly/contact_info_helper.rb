module Insightly
  module ContactInfoHelper
    def contact_infos
         @data["CONTACTINFOS"].collect {|a| Insightly::ContactInfo.build(a)}
     end
     def contact_infos=(list)
       @data["CONTACTINFOS"] = list.collect {|a| a.remote_data}
     end
     def add_contact_info(contact_info)
       @data["CONTACTINFOS"] ||= []
       @data["CONTACTINFOS"] << contact_info.remote_data
       true
     end
  end
end