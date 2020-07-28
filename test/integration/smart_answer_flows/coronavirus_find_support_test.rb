require_relative "../../test_helper"
require_relative "flow_test_helper"

require "smart_answer_flows/coronavirus-find-support.rb"

class CoronavirusFindSupportFlowTest < ActiveSupport::TestCase
  include FlowTestHelper

  setup do
    setup_for_testing_flow SmartAnswer::CoronavirusFindSupportFlow
  end

  context "all combinations of all options" do
    should "show results when only nothing is selected" do
      assert_current_node :need_help_with?
      add_response ""
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when only feeling_unsafe is selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when only paying_bills is selected" do
      assert_current_node :need_help_with?
      add_response "paying_bills"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when only getting_food is selected" do
      assert_current_node :need_help_with?
      add_response "getting_food"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when only being_unemployed is selected" do
      assert_current_node :need_help_with?
      add_response "being_unemployed"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when only going_to_work is selected" do
      assert_current_node :need_help_with?
      add_response "going_to_work"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when only somewhere_to_live is selected" do
      assert_current_node :need_help_with?
      add_response "somewhere_to_live"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when only mental_health is selected" do
      assert_current_node :need_help_with?
      add_response "mental_health"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe and paying_bills are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,paying_bills"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe and getting_food are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,getting_food"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe and being_unemployed are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,being_unemployed"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe and going_to_work are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,going_to_work"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe and somewhere_to_live are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,somewhere_to_live"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,mental_health"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when paying_bills and getting_food are selected" do
      assert_current_node :need_help_with?
      add_response "paying_bills,getting_food"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when paying_bills and being_unemployed are selected" do
      assert_current_node :need_help_with?
      add_response "paying_bills,being_unemployed"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when paying_bills and going_to_work are selected" do
      assert_current_node :need_help_with?
      add_response "paying_bills,going_to_work"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when paying_bills and somewhere_to_live are selected" do
      assert_current_node :need_help_with?
      add_response "paying_bills,somewhere_to_live"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when paying_bills and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "paying_bills,mental_health"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when getting_food and being_unemployed are selected" do
      assert_current_node :need_help_with?
      add_response "getting_food,being_unemployed"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when getting_food and going_to_work are selected" do
      assert_current_node :need_help_with?
      add_response "getting_food,going_to_work"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when getting_food and somewhere_to_live are selected" do
      assert_current_node :need_help_with?
      add_response "getting_food,somewhere_to_live"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when getting_food and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "getting_food,mental_health"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when being_unemployed and going_to_work are selected" do
      assert_current_node :need_help_with?
      add_response "being_unemployed,going_to_work"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when being_unemployed and somewhere_to_live are selected" do
      assert_current_node :need_help_with?
      add_response "being_unemployed,somewhere_to_live"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when being_unemployed and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "being_unemployed,mental_health"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when going_to_work and somewhere_to_live are selected" do
      assert_current_node :need_help_with?
      add_response "going_to_work,somewhere_to_live"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when going_to_work and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "going_to_work,mental_health"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when somewhere_to_live and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "somewhere_to_live,mental_health"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, paying_bills, and getting_food are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,paying_bills,getting_food"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, paying_bills, and being_unemployed are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,paying_bills,being_unemployed"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, paying_bills, and going_to_work are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,paying_bills,going_to_work"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, paying_bills, and somewhere_to_live are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,paying_bills,somewhere_to_live"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, paying_bills, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,paying_bills,mental_health"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, getting_food, and being_unemployed are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,getting_food,being_unemployed"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, getting_food, and going_to_work are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,getting_food,going_to_work"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, getting_food, and somewhere_to_live are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,getting_food,somewhere_to_live"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, getting_food, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,getting_food,mental_health"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, being_unemployed, and going_to_work are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,being_unemployed,going_to_work"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, being_unemployed, and somewhere_to_live are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,being_unemployed,somewhere_to_live"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, being_unemployed, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,being_unemployed,mental_health"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, going_to_work, and somewhere_to_live are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,going_to_work,somewhere_to_live"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, going_to_work, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,going_to_work,mental_health"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, somewhere_to_live, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,somewhere_to_live,mental_health"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when paying_bills, getting_food, and being_unemployed are selected" do
      assert_current_node :need_help_with?
      add_response "paying_bills,getting_food,being_unemployed"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when paying_bills, getting_food, and going_to_work are selected" do
      assert_current_node :need_help_with?
      add_response "paying_bills,getting_food,going_to_work"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when paying_bills, getting_food, and somewhere_to_live are selected" do
      assert_current_node :need_help_with?
      add_response "paying_bills,getting_food,somewhere_to_live"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when paying_bills, getting_food, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "paying_bills,getting_food,mental_health"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when paying_bills, being_unemployed, and going_to_work are selected" do
      assert_current_node :need_help_with?
      add_response "paying_bills,being_unemployed,going_to_work"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when paying_bills, being_unemployed, and somewhere_to_live are selected" do
      assert_current_node :need_help_with?
      add_response "paying_bills,being_unemployed,somewhere_to_live"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when paying_bills, being_unemployed, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "paying_bills,being_unemployed,mental_health"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when paying_bills, going_to_work, and somewhere_to_live are selected" do
      assert_current_node :need_help_with?
      add_response "paying_bills,going_to_work,somewhere_to_live"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when paying_bills, going_to_work, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "paying_bills,going_to_work,mental_health"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when paying_bills, somewhere_to_live, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "paying_bills,somewhere_to_live,mental_health"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when getting_food, being_unemployed, and going_to_work are selected" do
      assert_current_node :need_help_with?
      add_response "getting_food,being_unemployed,going_to_work"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when getting_food, being_unemployed, and somewhere_to_live are selected" do
      assert_current_node :need_help_with?
      add_response "getting_food,being_unemployed,somewhere_to_live"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when getting_food, being_unemployed, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "getting_food,being_unemployed,mental_health"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when getting_food, going_to_work, and somewhere_to_live are selected" do
      assert_current_node :need_help_with?
      add_response "getting_food,going_to_work,somewhere_to_live"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when getting_food, going_to_work, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "getting_food,going_to_work,mental_health"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when getting_food, somewhere_to_live, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "getting_food,somewhere_to_live,mental_health"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when being_unemployed, going_to_work, and somewhere_to_live are selected" do
      assert_current_node :need_help_with?
      add_response "being_unemployed,going_to_work,somewhere_to_live"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when being_unemployed, going_to_work, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "being_unemployed,going_to_work,mental_health"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when being_unemployed, somewhere_to_live, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "being_unemployed,somewhere_to_live,mental_health"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when going_to_work, somewhere_to_live, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "going_to_work,somewhere_to_live,mental_health"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, paying_bills, getting_food, and being_unemployed are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,paying_bills,getting_food,being_unemployed"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, paying_bills, getting_food, and going_to_work are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,paying_bills,getting_food,going_to_work"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, paying_bills, getting_food, and somewhere_to_live are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,paying_bills,getting_food,somewhere_to_live"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, paying_bills, getting_food, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,paying_bills,getting_food,mental_health"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, paying_bills, being_unemployed, and going_to_work are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,paying_bills,being_unemployed,going_to_work"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, paying_bills, being_unemployed, and somewhere_to_live are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,paying_bills,being_unemployed,somewhere_to_live"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, paying_bills, being_unemployed, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,paying_bills,being_unemployed,mental_health"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, paying_bills, going_to_work, and somewhere_to_live are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,paying_bills,going_to_work,somewhere_to_live"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, paying_bills, going_to_work, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,paying_bills,going_to_work,mental_health"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, paying_bills, somewhere_to_live, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,paying_bills,somewhere_to_live,mental_health"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, getting_food, being_unemployed, and going_to_work are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,getting_food,being_unemployed,going_to_work"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, getting_food, being_unemployed, and somewhere_to_live are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,getting_food,being_unemployed,somewhere_to_live"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, getting_food, being_unemployed, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,getting_food,being_unemployed,mental_health"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, getting_food, going_to_work, and somewhere_to_live are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,getting_food,going_to_work,somewhere_to_live"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, getting_food, going_to_work, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,getting_food,going_to_work,mental_health"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, getting_food, somewhere_to_live, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,getting_food,somewhere_to_live,mental_health"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, being_unemployed, going_to_work, and somewhere_to_live are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,being_unemployed,going_to_work,somewhere_to_live"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, being_unemployed, going_to_work, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,being_unemployed,going_to_work,mental_health"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, being_unemployed, somewhere_to_live, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,being_unemployed,somewhere_to_live,mental_health"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, going_to_work, somewhere_to_live, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,going_to_work,somewhere_to_live,mental_health"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when paying_bills, getting_food, being_unemployed, and going_to_work are selected" do
      assert_current_node :need_help_with?
      add_response "paying_bills,getting_food,being_unemployed,going_to_work"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when paying_bills, getting_food, being_unemployed, and somewhere_to_live are selected" do
      assert_current_node :need_help_with?
      add_response "paying_bills,getting_food,being_unemployed,somewhere_to_live"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when paying_bills, getting_food, being_unemployed, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "paying_bills,getting_food,being_unemployed,mental_health"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when paying_bills, getting_food, going_to_work, and somewhere_to_live are selected" do
      assert_current_node :need_help_with?
      add_response "paying_bills,getting_food,going_to_work,somewhere_to_live"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when paying_bills, getting_food, going_to_work, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "paying_bills,getting_food,going_to_work,mental_health"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when paying_bills, getting_food, somewhere_to_live, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "paying_bills,getting_food,somewhere_to_live,mental_health"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when paying_bills, being_unemployed, going_to_work, and somewhere_to_live are selected" do
      assert_current_node :need_help_with?
      add_response "paying_bills,being_unemployed,going_to_work,somewhere_to_live"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when paying_bills, being_unemployed, going_to_work, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "paying_bills,being_unemployed,going_to_work,mental_health"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when paying_bills, being_unemployed, somewhere_to_live, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "paying_bills,being_unemployed,somewhere_to_live,mental_health"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when paying_bills, going_to_work, somewhere_to_live, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "paying_bills,going_to_work,somewhere_to_live,mental_health"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when getting_food, being_unemployed, going_to_work, and somewhere_to_live are selected" do
      assert_current_node :need_help_with?
      add_response "getting_food,being_unemployed,going_to_work,somewhere_to_live"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when getting_food, being_unemployed, going_to_work, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "getting_food,being_unemployed,going_to_work,mental_health"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when getting_food, being_unemployed, somewhere_to_live, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "getting_food,being_unemployed,somewhere_to_live,mental_health"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when getting_food, going_to_work, somewhere_to_live, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "getting_food,going_to_work,somewhere_to_live,mental_health"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when being_unemployed, going_to_work, somewhere_to_live, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "being_unemployed,going_to_work,somewhere_to_live,mental_health"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, paying_bills, getting_food, being_unemployed, and going_to_work are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,paying_bills,getting_food,being_unemployed,going_to_work"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, paying_bills, getting_food, being_unemployed, and somewhere_to_live are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,paying_bills,getting_food,being_unemployed,somewhere_to_live"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, paying_bills, getting_food, being_unemployed, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,paying_bills,getting_food,being_unemployed,mental_health"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, paying_bills, getting_food, going_to_work, and somewhere_to_live are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,paying_bills,getting_food,going_to_work,somewhere_to_live"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, paying_bills, getting_food, going_to_work, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,paying_bills,getting_food,going_to_work,mental_health"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, paying_bills, getting_food, somewhere_to_live, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,paying_bills,getting_food,somewhere_to_live,mental_health"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, paying_bills, being_unemployed, going_to_work, and somewhere_to_live are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,paying_bills,being_unemployed,going_to_work,somewhere_to_live"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, paying_bills, being_unemployed, going_to_work, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,paying_bills,being_unemployed,going_to_work,mental_health"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, paying_bills, being_unemployed, somewhere_to_live, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,paying_bills,being_unemployed,somewhere_to_live,mental_health"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, paying_bills, going_to_work, somewhere_to_live, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,paying_bills,going_to_work,somewhere_to_live,mental_health"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, getting_food, being_unemployed, going_to_work, and somewhere_to_live are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,getting_food,being_unemployed,going_to_work,somewhere_to_live"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, getting_food, being_unemployed, going_to_work, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,getting_food,being_unemployed,going_to_work,mental_health"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, getting_food, being_unemployed, somewhere_to_live, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,getting_food,being_unemployed,somewhere_to_live,mental_health"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, getting_food, going_to_work, somewhere_to_live, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,getting_food,going_to_work,somewhere_to_live,mental_health"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, being_unemployed, going_to_work, somewhere_to_live, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,being_unemployed,going_to_work,somewhere_to_live,mental_health"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when paying_bills, getting_food, being_unemployed, going_to_work, and somewhere_to_live are selected" do
      assert_current_node :need_help_with?
      add_response "paying_bills,getting_food,being_unemployed,going_to_work,somewhere_to_live"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when paying_bills, getting_food, being_unemployed, going_to_work, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "paying_bills,getting_food,being_unemployed,going_to_work,mental_health"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when paying_bills, getting_food, being_unemployed, somewhere_to_live, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "paying_bills,getting_food,being_unemployed,somewhere_to_live,mental_health"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when paying_bills, getting_food, going_to_work, somewhere_to_live, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "paying_bills,getting_food,going_to_work,somewhere_to_live,mental_health"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when paying_bills, being_unemployed, going_to_work, somewhere_to_live, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "paying_bills,being_unemployed,going_to_work,somewhere_to_live,mental_health"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when getting_food, being_unemployed, going_to_work, somewhere_to_live, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "getting_food,being_unemployed,going_to_work,somewhere_to_live,mental_health"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, paying_bills, getting_food, being_unemployed, going_to_work, and somewhere_to_live are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,paying_bills,getting_food,being_unemployed,going_to_work,somewhere_to_live"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, paying_bills, getting_food, being_unemployed, going_to_work, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,paying_bills,getting_food,being_unemployed,going_to_work,mental_health"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, paying_bills, getting_food, being_unemployed, somewhere_to_live, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,paying_bills,getting_food,being_unemployed,somewhere_to_live,mental_health"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, paying_bills, getting_food, going_to_work, somewhere_to_live, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,paying_bills,getting_food,going_to_work,somewhere_to_live,mental_health"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, paying_bills, being_unemployed, going_to_work, somewhere_to_live, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,paying_bills,being_unemployed,going_to_work,somewhere_to_live,mental_health"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, getting_food, being_unemployed, going_to_work, somewhere_to_live, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,getting_food,being_unemployed,going_to_work,somewhere_to_live,mental_health"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when paying_bills, getting_food, being_unemployed, going_to_work, somewhere_to_live, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "paying_bills,getting_food,being_unemployed,going_to_work,somewhere_to_live,mental_health"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results when feeling_unsafe, paying_bills, getting_food, being_unemployed, going_to_work, somewhere_to_live, and mental_health are selected" do
      assert_current_node :need_help_with?
      add_response "feeling_unsafe,paying_bills,getting_food,being_unemployed,going_to_work,somewhere_to_live,mental_health"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :afford_food?
      add_response "no"
      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"
      assert_current_node :worried_about_work?
      add_response "no"
      assert_current_node :have_somewhere_to_live?
      add_response "yes"
      assert_current_node :have_you_been_evicted?
      add_response "no"
      assert_current_node :mental_health_worries?
      add_response "no"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end
  end

  context "specific outcomes" do
    should "show results for a user that can get food and is self-employed" do
      assert_current_node :need_help_with?
      add_response "being_unemployed,feeling_unsafe,getting_food,going_to_work,mental_health,paying_bills,somewhere_to_live"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :afford_food?
      add_response "no"

      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :self_employed?
      add_response "yes"

      assert_current_node :worried_about_work?
      add_response "yes"
      assert_current_node :have_somewhere_to_live?
      add_response "no"
      assert_current_node :have_you_been_evicted?
      add_response "yes"
      assert_current_node :mental_health_worries?
      add_response "yes"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results for a user that cannot get food, is not self-employed, and has been made unemployed" do
      assert_current_node :need_help_with?
      add_response "being_unemployed,feeling_unsafe,getting_food,going_to_work,mental_health,paying_bills,somewhere_to_live"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :afford_food?
      add_response "no"

      assert_current_node :get_food?
      add_response "no"
      assert_current_node :able_to_go_out?
      add_response "yes"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "yes_i_have_been_made_unemployed"

      assert_current_node :worried_about_work?
      add_response "yes"
      assert_current_node :have_somewhere_to_live?
      add_response "no"
      assert_current_node :have_you_been_evicted?
      add_response "yes"
      assert_current_node :mental_health_worries?
      add_response "yes"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end

    should "show results for a user that can get food, is not self-employed, and has not been made unemployed" do
      assert_current_node :need_help_with?
      add_response "being_unemployed,feeling_unsafe,getting_food,going_to_work,mental_health,paying_bills,somewhere_to_live"
      assert_current_node :feel_safe?
      add_response "no"
      assert_current_node :afford_rent_mortgage_bills?
      add_response "no"
      assert_current_node :afford_food?
      add_response "no"

      assert_current_node :get_food?
      add_response "yes"
      assert_current_node :self_employed?
      add_response "no"
      assert_current_node :have_you_been_made_unemployed?
      add_response "no"
      assert_current_node :are_you_off_work_ill?
      add_response "no"

      assert_current_node :worried_about_work?
      add_response "yes"
      assert_current_node :have_somewhere_to_live?
      add_response "no"
      assert_current_node :have_you_been_evicted?
      add_response "yes"
      assert_current_node :mental_health_worries?
      add_response "yes"
      assert_current_node :nation?
      add_response "england,scotland,wales,northern_ireland"
      assert_current_node :results
    end
  end
end
