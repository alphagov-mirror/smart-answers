module CoronavirusFindSupport
  class AbleToGoOutForm < Form
    def initialize(params, session)
      super(params, session, :session_answers, :able_to_go_out)
    end
  end
end
