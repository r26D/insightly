module Insightly
  class OpportunityStateReason < ReadOnly
    URL_BASE =  "OpportunityStateReasons"

    def state
      @data["FOR_OPPORTUNITY_STATE"]
    end
    def self.find_by_state(state)
      list = []
      OpportunityStateReason.all.each.each do |x|
        if x.state && x.state.match(state)
          list << x
        end
      end
      list
    end

    def self.open
      OpportunityStateReason.find_by_state("Open")
    end

    def self.lost
      OpportunityStateReason.find_by_state("Lost")
    end

    def self.abandoned
      OpportunityStateReason.find_by_state("Abandoned")
    end

    def self.won
      OpportunityStateReason.find_by_state("Won")
    end

    def self.suspended
      OpportunityStateReason.find_by_state("Suspended")
    end

  end
end