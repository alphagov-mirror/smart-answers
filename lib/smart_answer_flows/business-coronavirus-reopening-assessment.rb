module SmartAnswer
  class BusinessCoronavirusReopeningAssessmentFlow < Flow
    def define
      name "business-coronavirus-reopening-assessment"
      start_page_content_id "00c39c07-4595-4927-8b81-64a4def8e596"
      flow_content_id "4590e82c-7f16-41a9-b3b6-1e63aaa72fc1"
      status :draft

      checkbox_question :sectors? do
        option :construction
        option :factories
        option :labs
        option :offices
        option :homes
        option :hospitality
        option :shops
        option :vehicles
        set_none_option(label: "None of the above")

        on_response do |response|
          self.calculator = Calculators::BusinessCoronavirusReopeningAssessmentCalculator.new
          calculator.sectors = response
        end

        next_node do
          question :number_of_employees?
        end
      end

      multiple_choice :number_of_employees? do
        option :up_to_4
        option :over_4

        on_response do |response|
          calculator.number_of_employees = response
        end

        next_node do
          question :vistors?
        end
      end

      multiple_choice :vistors? do
        option :yes
        option :no

        on_response do |response|
          calculator.vistors = response
        end

        next_node do
          question :staff_meetings?
        end
      end

      multiple_choice :staff_meetings? do
        option :yes
        option :no

        on_response do |response|
          calculator.staff_meetings = response
        end

        next_node do
          question :staff_travel?
        end
      end

      multiple_choice :staff_travel? do
        option :yes
        option :no

        on_response do |response|
          calculator.staff_travel = response
        end

        next_node do
          question :send_or_receive_goods?
        end
      end

      multiple_choice :send_or_receive_goods? do
        option :yes
        option :no

        on_response do |response|
          calculator.send_or_receive_goods = response
        end

        next_node do
          outcome :results
        end
      end

      outcome :results
    end
  end
end
