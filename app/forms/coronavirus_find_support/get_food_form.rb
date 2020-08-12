module CoronavirusFindSupport
  class GetFoodForm < Form
    def initialize(params, session)
      super(params, session, :session_answers, :get_food)
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
