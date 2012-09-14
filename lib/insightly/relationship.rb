module Insightly
  class Relationship < ReadOnly
    self.url_base = "Relationships"
    api_field "RELATIONSHIP_ID",
              "FOR_ORGANISATIONS",
              "FOR_CONTACTS",
              "REVERSE_TITLE",
              "FORWARD",
              "REVERSE",
              "FORWARD_TITLE"

    def remote_id
      self.relationship_id
    end
  end
end