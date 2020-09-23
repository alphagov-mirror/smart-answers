require_relative "../../test_helper"
require_relative "flow_test_helper"

require "smart_answer_flows/coronavirus-find-support.rb"

class CoronavirusFindSupportFlowTest < ActiveSupport::TestCase
  include FlowTestHelper

  setup do
    setup_for_testing_flow SmartAnswer::CoronavirusFindSupportFlow
  end

  context "specific outcomes" do
    should "ask the user to answer questions in all groups if none is selected for the need_help_with question" do
      assert_current_node :need_help_with
      add_response "none"

      # ======================================================================
      # Group: feeling_unsafe
      # ======================================================================
      assert_current_node :feel_safe
      add_response "yes"

      # ======================================================================
      # Group: paying_bills
      # ======================================================================
      assert_current_node :afford_rent_mortgage_bills
      add_response "no"

      # ======================================================================
      # Group: getting_food
      # ======================================================================
      assert_current_node :afford_food
      add_response "no"
      assert_current_node :get_food
      add_response "yes"

      # ======================================================================
      # Group: being_unemployed
      # ======================================================================
      assert_current_node :self_employed
      add_response "no"
      assert_current_node :have_you_been_made_unemployed
      add_response "no"

      # ======================================================================
      # Group: going_in_to_work
      # ======================================================================
      assert_current_node :worried_about_work
      add_response "no"
      assert_current_node :are_you_off_work_ill
      add_response "no"

      # ======================================================================
      # Group: somewhere_to_live
      # ======================================================================
      assert_current_node :have_somewhere_to_live
      add_response "yes"
      assert_current_node :have_you_been_evicted
      add_response "no"

      # ======================================================================
      # Group: mental_health
      # ======================================================================
      assert_current_node :mental_health_worries
      add_response "no"

      assert_current_node :nation
      add_response "england"
      assert_current_node :results
    end

    should "show no specific information results for the minimal flow" do
      assert_current_node :need_help_with
      add_response "feeling_unsafe"
      assert_current_node :feel_safe
      add_response "yes"
      assert_current_node :nation
      add_response "england"
      assert_current_node :results
    end

    should "show results for a user that can get food and is self-employed" do
      assert_current_node :need_help_with
      add_response "being_unemployed,feeling_unsafe,getting_food,going_to_work,mental_health,paying_bills,somewhere_to_live"
      assert_current_node :feel_safe
      add_response "no"
      assert_current_node :afford_rent_mortgage_bills
      add_response "no"
      assert_current_node :afford_food
      add_response "no"

      assert_current_node :get_food
      add_response "yes"
      assert_current_node :self_employed
      add_response "yes"

      assert_current_node :worried_about_work
      add_response "yes"
      assert_current_node :are_you_off_work_ill
      add_response "yes"
      assert_current_node :have_somewhere_to_live
      add_response "no"
      assert_current_node :have_you_been_evicted
      add_response "yes"
      assert_current_node :mental_health_worries
      add_response "yes"
      assert_current_node :nation
      add_response "england"
      assert_current_node :results
    end

    should "show results for a user that cannot get food, is not self-employed, and has been made unemployed" do
      assert_current_node :need_help_with
      add_response "being_unemployed,feeling_unsafe,getting_food,going_to_work,mental_health,paying_bills,somewhere_to_live"
      assert_current_node :feel_safe
      add_response "no"
      assert_current_node :afford_rent_mortgage_bills
      add_response "no"
      assert_current_node :afford_food
      add_response "no"

      assert_current_node :get_food
      add_response "no"
      assert_current_node :self_employed
      add_response "no"
      assert_current_node :have_you_been_made_unemployed
      add_response "yes_i_have_been_made_unemployed"

      assert_current_node :worried_about_work
      add_response "yes"
      assert_current_node :are_you_off_work_ill
      add_response "no"
      assert_current_node :have_somewhere_to_live
      add_response "no"
      assert_current_node :have_you_been_evicted
      add_response "yes"
      assert_current_node :mental_health_worries
      add_response "yes"
      assert_current_node :nation
      add_response "england"
      assert_current_node :results
    end

    should "show results for a user that can get food, is not self-employed, and has not been made unemployed" do
      assert_current_node :need_help_with
      add_response "being_unemployed,feeling_unsafe,getting_food,going_to_work,mental_health,paying_bills,somewhere_to_live"
      assert_current_node :feel_safe
      add_response "no"
      assert_current_node :afford_rent_mortgage_bills
      add_response "no"
      assert_current_node :afford_food
      add_response "no"

      assert_current_node :get_food
      add_response "yes"
      assert_current_node :self_employed
      add_response "no"
      assert_current_node :have_you_been_made_unemployed
      add_response "no"
      assert_current_node :worried_about_work
      add_response "yes"
      assert_current_node :are_you_off_work_ill
      add_response "no"
      assert_current_node :have_somewhere_to_live
      add_response "no"
      assert_current_node :have_you_been_evicted
      add_response "yes"
      assert_current_node :mental_health_worries
      add_response "yes"

      assert_current_node :nation
      add_response "england"
      assert_current_node :results
    end

    should "not be possible to reach the results page without the no-results text being shown" do
      assert_current_node :need_help_with
      add_response "feeling_unsafe"
      assert_current_node :feel_safe
      add_response "yes"
      assert_current_node :nation
      add_response "england"
      assert_current_node :results

      assert_match(/Based on your answers, there’s no specific information for you in this service at the moment. It will be updated regularly./, outcome_body)
    end

    should "show only the appropriate sub-sections that are required based on the users given responses" do
      assert_current_node :need_help_with
      add_response "getting_food"
      assert_current_node :afford_food
      add_response "yes"
      assert_current_node :get_food
      add_response "yes"
      assert_current_node :nation
      add_response "england"
      assert_current_node :results

      assert_match(/Getting food/, outcome_body)
      assert_match(/If you’re finding it hard to afford food/, outcome_body)
      assert_no_match(/If you’re unable to get food/, outcome_body)
    end
  end
end
