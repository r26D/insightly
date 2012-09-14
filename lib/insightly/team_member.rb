module Insightly
  class TeamMember < ReadOnly
    self.url_base = "TeamMembers"
    api_field "MEMBER_TEAM_ID",
              "TEAM_ID",
              "MEMBER_USER_ID",
              "PERMISSION_ID"

    def remote_id
      self.team_id
    end
  end
end