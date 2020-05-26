module SmartAnswer::Calculators
  class BusinessCoronavirusReopeningAssessmentCalculator
    attr_accessor :sectors,
                  :number_of_employees,
                  :vistors,
                  :staff_meetings,
                  :staff_travel,
                  :send_or_receive_goods

    RULES = {
      staff: lambda { |calculator|
        calculator.number_of_employees == "over_4"
      },
      visitors: lambda { |calculator|
        calculator.vistors == "yes"
      },
      staff_meetings: lambda { |calculator|
        calculator.staff_meetings == "yes"
      },
      staff_travel: lambda { |calculator|
        calculator.staff_travel == "yes"
      },
      send_or_receive_goods: lambda { |calculator|
        calculator.send_or_receive_goods == "yes"
      },
    }.freeze

    def sector?(sector)
      sectors.include?(sector)
    end

    def show?(result_id)
      RULES[result_id].call(self)
    end
  end
end
