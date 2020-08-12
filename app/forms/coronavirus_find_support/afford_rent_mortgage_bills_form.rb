module CoronavirusFindSupport
  class AffordRentMortgageBillsForm < Form
    def initialize(params, session)
      super(params, session, :session_answers, :afford_rent_mortgage_bills)
    end

    def options
      {
        yes: "Yes",
        no: "No",
        not_sure: "Not sure",
      }
    end
  end
end
