module Insightly
  module AddressHelper
    def addresses
         @data["ADDRESSES"].collect {|a| Insightly::Address.build(a)}
     end
     def addresses=(list)
       @data["ADDRESSES"] = list.collect {|a| a.remote_data}
     end
     def add_address(address)

       @data["ADDRESSES"].each do |a|
         if  address.same_address?(Insightly::Address.build(a))

           return false
         end
       end
       @data["ADDRESSES"] << address.remote_data
       true
     end
  end
end