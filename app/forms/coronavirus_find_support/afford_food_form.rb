module CoronavirusFindSupport
  class AffordFoodForm < Form
    def initialize(params, session)
      super(params, session, :session_answers, :afford_food)
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
