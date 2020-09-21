module SmartAnswer::Calculators
  class CoronavirusFindSupportCalculator
    attr_accessor :nation,
                  :need_help_with,
                  :feel_safe,
                  :afford_rent_mortgage_bills,
                  :afford_food,
                  :get_food,
                  :self_employed,
                  :worried_about_work,
                  :have_somewhere_to_live,
                  :have_you_been_evicted,
                  :are_you_off_work_ill,
                  :have_you_been_made_unemployed,
                  :mental_health_worries

    RULES = {
      feeling_unsafe: lambda { |calculator|
        calculator.needs_help_with?("feeling_unsafe") && calculator.feel_safe != "yes"
      },
      paying_bills: lambda { |calculator|
        calculator.needs_help_with?("paying_bills") && calculator.afford_rent_mortgage_bills != "no"
      },
      getting_food: lambda { |calculator|
        calculator.needs_help_with?("getting_food") &&
          (calculator.afford_food != "no" && calculator.get_food != "yes")
      },
      going_to_work: lambda { |calculator|
        calculator.needs_help_with?("going_to_work") && calculator.worried_about_work != "no"
      },
      being_unemployed: lambda { |calculator|
        calculator.needs_help_with?("being_unemployed") && (
          (calculator.self_employed != "yes" && calculator.have_you_been_made_unemployed != "no") || calculator.are_you_off_work_ill == "yes"
        )
      },
      somewhere_to_live: lambda { |calculator|
        calculator.needs_help_with?("somewhere_to_live") && (
          calculator.have_somewhere_to_live != "yes" || calculator.have_you_been_evicted != "no"
        )
      },
      mental_health: lambda { |calculator|
        calculator.needs_help_with?("mental_health") && calculator.mental_health_worries != "no"
      },
    }.freeze

    def show?(section)
      RULES[section].call(self)
    end

    def has_results?
      RULES.keys.map { |key| RULES[key].call(self) }.uniq.include? true
    end

    def needs_help_with?(given_help_item)
      return false if need_help_with.blank?

      need_help_with.split(",").include? given_help_item
    end

    def needs_help_in?(given_nation)
      nation == given_nation
    end

    def next_question(current_node)
      nodes = %i[
        need_help_with
        feel_safe
        afford_rent_mortgage_bills
        get_food
        have_you_been_made_unemployed
        are_you_off_work_ill
        have_you_been_evicted
      ]

      if nodes.slice(0..0).include?(current_node) && needs_help_with?("feeling_unsafe")
        :feel_safe
      elsif nodes.slice(0..1).include?(current_node) && needs_help_with?("paying_bills")
        :afford_rent_mortgage_bills
      elsif nodes.slice(0..2).include?(current_node) && needs_help_with?("getting_food")
        :afford_food
      elsif nodes.slice(0..3).include?(current_node) && needs_help_with?("being_unemployed")
        :self_employed
      elsif nodes.slice(0..4).include?(current_node) && needs_help_with?("going_to_work")
        :worried_about_work
      elsif nodes.slice(0..5).include?(current_node) && needs_help_with?("somewhere_to_live")
        :have_somewhere_to_live
      elsif nodes.slice(0..6).include?(current_node) && needs_help_with?("mental_health")
        :mental_health_worries
      else
        :nation
      end
    end
  end
end
