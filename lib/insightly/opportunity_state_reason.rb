#METODO for consistency move state back to opportunity_state

module Insightly
  class OpportunityStateReason < ReadOnly
    URL_BASE = "OpportunityStateReasons"
    STATES = ["Abandoned", "Lost", "Open", "Suspended", "Won"]

    def opportunity_state
      @data["FOR_OPPORTUNITY_STATE"]
    end

    def self.find_by_state(state)
      list = []
      OpportunityStateReason.all.each.each do |x|
        if x.opportunity_state && x.opportunity_state.match(state)
          list << x
        end
      end
      list
    end

    STATES.each do |state|

      (
      class << self;
        self;
      end).instance_eval do
        define_method state.downcase.to_sym do
          OpportunityStateReason.find_by_state(state)
        end
      end

    end

  end
end