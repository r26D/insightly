module Insightly
  class Tag < BaseData
    api_field "TAG_NAME"

    def build(data)
      if data.respond_to? :keys
        @data = data
      else
        @data = {"TAG_NAME" => data}
      end
      self
    end


  end

end