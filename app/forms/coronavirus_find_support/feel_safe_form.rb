module CoronavirusFindSupport
  class FeelSafeForm < Form
    def initialize(params, session)
      super(params, session, :session_answers, :feel_safe)
    end

    def options
      {
        yes: "Yes",
        yes_but_i_am_concerned_about_others: "Yes, but I’m worried about the safety of another adult or a child",
        no: "No",
        not_sure: "Not sure",
      }
    end
  end
end
