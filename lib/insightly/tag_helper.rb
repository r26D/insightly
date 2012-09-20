module Insightly
  module TagHelper
    def tags
         @data["TAGS"]  ||= []
         @data["TAGS"].collect {|a| Insightly::Tag.build(a)}
     end
     def tags=(list)
       @data["TAGS"] = list.collect {|a| a.remote_data}
     end
     def add_tag(tag)
       @data["TAGS"]  ||= []
       @data["TAGS"] << tag.remote_data
       true
     end
  end
end