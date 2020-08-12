module CoronavirusFindSupport
  class NeedHelpWithForm < Form
    def initialize(params, session)
      super(params, session, :session_answers, :need_help_with)
    end

    def options
      {
        feeling_unsafe: "Feeling unsafe where you live, or being worried about someone else",
        paying_bills: "Paying bills",
        getting_food: "Getting food",
        being_unemployed: "Being unemployed or not having any work",
        going_to_work: "Going in to work",
        somewhere_to_live: "Having somewhere to live",
        mental_health: "Mental health and wellbeing",
        not_sure: "I'm not sure",
      }
    end
  end
end
