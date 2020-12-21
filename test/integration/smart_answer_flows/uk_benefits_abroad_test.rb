require_relative "../../test_helper"
require_relative "flow_test_helper"

require "smart_answer_flows/uk-benefits-abroad"

class UKBenefitsAbroadTest < ActiveSupport::TestCase
  include FlowTestHelper

  setup do
    setup_for_testing_flow SmartAnswer::UkBenefitsAbroadFlow
    stub_world_locations %w[albania austria canada ireland jamaica jersey kosovo]
  end

  # Q1
  should "ask if you are going abroad or are already abroad" do
    assert_current_node :going_or_already_abroad?
  end

  # Going abroad
  context "when going abroad" do
    setup do
      add_response "going_abroad"
    end

    should "ask which benefit you're interested in" do
      assert_current_node :which_benefit?
    end
    # JSA
    context "answer JSA" do
      setup do
        add_response "jsa"
      end
      should "ask which country are you moving to?" do
        assert_current_node :which_country?
      end

      context "answer EEA country" do
        setup do
          add_response "austria"
        end
        should "ask have you ever worked in an EU country, Norway, Iceland, Liechtenstein or Switzerland?" do
          assert_current_node :worked_in_eea_or_switzerland?
        end

        context "answer yes before 1 January 2021" do
          setup do
            add_response "before_jan_2021"
          end
          should "go to the JSA EEA maybe outcome" do # /going_abroad/jsa/austria/before_jan_2021
            assert_current_node :jsa_eea_going_abroad_maybe_outcome
          end
        end

        context "answer yes after 1 January 2021" do
          setup do
            add_response "after_jan_2021"
          end
          should "ask has one of your parents ever lived in an EU country, Norway, Iceland, Liechtenstein or Switzerland?" do # /going_abroad/jsa/austria/after_jan_2021
            assert_current_node :parents_lived_in_eea_or_switzerland?
          end

          context "answer yes before 1 January 2021" do
            setup do
              add_response "before_jan_2021"
            end
            should "go to the JSA EEA maybe outcome" do # /going_abroad/jsa/austria/after_jan_2021/before_jan_2021
              assert_current_node :jsa_eea_going_abroad_maybe_outcome
            end
          end

          context "answer yes after 1 January 2021" do
            setup do
              add_response "after_jan_2021"
            end
            should "go to the JSA not entitled outcome" do # /going_abroad/jsa/austria/after_jan_2021/after_jan_2021
              assert_current_node :jsa_not_entitled_outcome
            end
          end

          context "no" do
            setup do
              add_response "no"
            end
            should "go to the JSA not entitled outcome" do # /going_abroad/jsa/austria/no/after_jan_2021
              assert_current_node :jsa_not_entitled_outcome
            end
          end
        end

        context "no" do
          setup do
            add_response "no"
          end
          should "ask has one of your parents ever lived in an EU country, Norway, Iceland, Liechtenstein or Switzerland?" do
            assert_current_node :parents_lived_in_eea_or_switzerland?
          end

          context "answer yes before 1 January 2021" do
            setup do
              add_response "before_jan_2021"
            end
            should "go to the JSA EEA maybe outcome" do # /going_abroad/jsa/austria/no/before_jan_2021
              assert_current_node :jsa_eea_going_abroad_maybe_outcome
            end
          end

          context "answer yes after 1 January 2021" do
            setup do
              add_response "after_jan_2021"
            end
            should "go to the JSA not entitled outcome" do # /going_abroad/jsa/austria/no/after_jan_2021
              assert_current_node :jsa_not_entitled_outcome
            end
          end

          context "no" do
            setup do
              add_response "no"
            end
            should "go to the JSA not entitled outcome" do # /going_abroad/jsa/austria/no/no
              assert_current_node :jsa_not_entitled_outcome
            end
          end
        end
      end

      context "answer Ireland" do
        setup do
          add_response "ireland"
        end
        should "ask are you a British or Irish citizen?" do
          assert_current_node :is_british_or_irish?
        end

        context "answer yes" do
          setup do
            add_response "yes"
          end
          should "go to JSA Ireland outcome" do
            assert_current_node :jsa_ireland_outcome
          end
        end

        context "answer no" do
          setup do
            add_response "no"
          end
          should "go to ask have you ever worked in an EU country, Norway, Iceland, Liechtenstein or Switzerland?" do
            assert_current_node :worked_in_eea_or_switzerland?
          end

          context "answer before January 2021" do
            setup do
              add_response "before_jan_2021"
            end
            should "go to the JSA EEA maybe outcome" do
              assert_current_node :jsa_eea_going_abroad_maybe_outcome
            end
          end

          context "answer after January 2021" do
            setup do
              add_response "after_jan_2021"
            end
            should "ask has one of your parents ever lived in an EU country, Norway, Iceland, Liechtenstein or Switzerland?" do
              assert_current_node :parents_lived_in_eea_or_switzerland?
            end
            context "answer before January 2021" do
              setup do
                add_response "before_jan_2021"
              end
              should "go to the JSA EEA maybe outcome" do
                assert_current_node :jsa_eea_going_abroad_maybe_outcome
              end
            end
            context "answer after January 2021" do
              setup do
                add_response "after_jan_2021"
              end
              should "go to jsa not entitled outcome" do
                assert_current_node :jsa_not_entitled_outcome
              end
            end
            context "answer no" do
              setup do
                add_response "no"
              end
              should "got to jsa not entitled outcome" do
                assert_current_node :jsa_not_entitled_outcome
              end
            end
          end

          context "answer no" do
            setup do
              add_response "no"
            end
            should "ask has one of your parents ever lived in an EU country, Norway, Iceland, Liechtenstein or Switzerland?" do
              assert_current_node :parents_lived_in_eea_or_switzerland?
            end
            context "answer before January 2021" do
              setup do
                add_response "before_jan_2021"
              end
              should "go to maybe jsa outcome" do
                assert_current_node :jsa_eea_going_abroad_maybe_outcome
              end
            end

            context "answer after January 2021" do
              setup do
                add_response "after_jan_2021"
              end
              should "go to jsa not entitled outcome" do
                assert_current_node :jsa_not_entitled_outcome
              end
            end

            context "answer no" do
              setup do
                add_response "no"
              end
              should "go to not entitled outcome" do
                assert_current_node :jsa_not_entitled_outcome
              end
            end
          end
        end
      end

      context "answer Jersey or Guernsey" do
        setup do
          add_response "jersey"
        end
        should "ask you how long are you going abroad for?" do
          assert_current_node :how_long_abroad?
        end

        context "answer less than one year" do
          setup do
            add_response "one_year_or_less"
          end
          should "go to Jersey Guernsey outcome" do
            assert_current_node :jsa_channel_islands_outcome
          end
        end

        context "answer more than one year" do
          setup do
            add_response "more_than_one_year"
          end
          should "go to JSA SS going abroad outcome" do
            assert_current_node :jsa_social_security_going_abroad_outcome
          end
        end
      end

      context "answer Kosovo" do
        setup do
          add_response "kosovo"
        end
        should "ask you how long are you going abroad for?" do
          assert_current_node :how_long_abroad?
        end
        context "answer 1 year or less" do
          setup do
            add_response "one_year_or_less"
          end
          should "go to JSA SS going abroad outcome" do
            assert_current_node :jsa_social_security_going_abroad_outcome
          end
        end

        context "answer more than a year" do
          setup do
            add_response "more_than_one_year"
          end
          should "go to JSA SS going abroad outcome" do
            assert_current_node :jsa_social_security_going_abroad_outcome
          end
        end
      end

      context "answer Albania" do
        setup do
          add_response "albania"
        end
        should "go to not entitled outcome" do
          assert_current_node :jsa_not_entitled_outcome
        end
      end
    end

    # Winter Fuel Payment
    context "answer WFP" do
      setup do
        add_response "winter_fuel_payment"
      end
      should "ask you which country you are moving to" do
        assert_current_node :which_country?
      end
      context "answer EEA country" do
        setup do
          add_response "austria"
        end
        should "ask have you ever worked in an EU country, Norway, Iceland, Liechtenstein or Switzerland?" do
          assert_current_node :worked_in_eea_or_switzerland?
        end
        context "answer before_jan_2021" do
          setup do
            add_response :before_jan_2021
          end
          should "go to outcome WFP EEA maybe" do
            assert_current_node :wfp_going_abroad_eea_maybe_outcome
          end
        end
        context "answer after_jan_2021" do
          setup do
            add_response :after_jan_2021
          end
          should "ask has one of your parents ever lived in an EU country, Norway, Iceland, Liechtenstein or Switzerland?" do # /going_abroad/jsa/austria/after_jan_2021
            assert_current_node :parents_lived_in_eea_or_switzerland?
          end
          context "answer before_jan_2021" do
            setup do
              add_response :before_jan_2021
            end
            should "go to outcome WFP EEA maybe" do
              assert_current_node :wfp_going_abroad_eea_maybe_outcome
            end
          end
          context "answer after_jan_2021" do
            setup do
              add_response :after_jan_2021
            end
            should "go to outcome WFP not eligible" do
              assert_current_node :wfp_not_eligible_outcome
            end
          end
          context "answer no" do
            setup do
              add_response :no
            end
            should "go to outcome WFP not eligible" do
              assert_current_node :wfp_not_eligible_outcome
            end
          end
        end
        context "answer no" do
          setup do
            add_response :no
          end
          should "ask has one of your parents ever lived in an EU country, Norway, Iceland, Liechtenstein or Switzerland?" do # /going_abroad/jsa/austria/after_jan_2021
            assert_current_node :parents_lived_in_eea_or_switzerland?
          end
          context "answer before_jan_2021" do
            setup do
              add_response :before_jan_2021
            end
            should "go to outcome WFP EEA maybe" do
              assert_current_node :wfp_going_abroad_eea_maybe_outcome
            end
          end
          context "answer after_jan_2021" do
            setup do
              add_response :after_jan_2021
            end
            should "go to outcome WFP not eligible" do
              assert_current_node :wfp_not_eligible_outcome
            end
          end
          context "answer no" do
            setup do
              add_response :no
            end
            should "go to outcome WFP not eligible" do
              assert_current_node :wfp_not_eligible_outcome
            end
          end
        end
      end

      context "answer Ireland" do
        setup do
          add_response :ireland
        end
        should "ask you if you are British or Irish?" do
          assert_current_node :is_british_or_irish?
        end
        context "answer yes" do # Are you a British or Irish citizen
          setup do
            add_response :yes
          end
          should "go to WFP Ireland outcome" do
            assert_current_node :wfp_ireland_outcome
          end
        end
        context "answer no" do # Are you a British or Irish citizen
          setup do
            add_response :no
          end
          should "Ask have you ever worked in an EU country, Norway, Iceland, Liechtenstein or Switzerland?" do
            assert_current_node :worked_in_eea_or_switzerland?
          end
          context "answer Yes before Jan 2021" do # Worked in EU?
            setup do
              add_response :before_jan_2021
            end
            should "go to outcome WFP EEA maybe" do
              assert_current_node :wfp_going_abroad_eea_maybe_outcome
            end
          end
          context "answer Yes after January 2021" do # Worked in EU?
            setup do
              add_response :after_jan_2021
            end
            should "ask has one of your parents ever lived in an EU country, Norway, Iceland, Liechtenstein or Switzerland?" do
              assert_current_node :parents_lived_in_eea_or_switzerland?
            end
            context "answer Yes before January 2021" do # parents EU?
              setup do
                add_response :before_jan_2021
              end
              should "go to outcome WFP EEA maybe" do
                assert_current_node :wfp_going_abroad_eea_maybe_outcome
              end
            end
            context "answer Yes after January 2021" do # parents EU?
              setup do
                add_response :after_jan_2021
              end
              should "go to outcome WFP EEA maybe" do
                assert_current_node :wfp_not_eligible_outcome
              end
            end
            context "answer no" do # parents EU?
              setup do
                add_response :no
              end
              should "go to outcome WFP EEA maybe" do
                assert_current_node :wfp_not_eligible_outcome
              end
            end
          end
          context "answer no" do # worked in EU?
            setup do
              add_response :no
            end
            should "Ask have you ever worked in an EU country, Norway, Iceland, Liechtenstein or Switzerland?" do
              assert_current_node :parents_lived_in_eea_or_switzerland?
            end
            context "answer yes before January 2021" do # parents EU?
              setup do
                add_response :before_jan_2021
              end
              should "go to outcome WFP EEA maybe" do
                assert_current_node :wfp_going_abroad_eea_maybe_outcome
              end
            end
            context "answer yes after January 2021" do # parents EU?
              setup do
                add_response :after_jan_2021
              end
              should "go to outcome WFP not eligible" do
                assert_current_node :wfp_not_eligible_outcome
              end
            end
            context "answer no" do # parents EU?
              setup do
                add_response :no
              end
              should "go to outcome WFP not eligible" do
                assert_current_node :wfp_not_eligible_outcome
              end
            end
          end
        end
      end
      context "answer Kosovo" do # SS country
        setup do
          add_response :kosovo
        end
        should "go to outcome WFP not eligible" do
          assert_current_node :wfp_not_eligible_outcome
        end
      end
    end

    # Maternity benefits
    context "answer maternity benefits" do
      setup do
        add_response "maternity_benefits"
      end
      should "ask you the country question" do
        assert_current_node :which_country?
      end

      context "answer Guernsey or Jersey" do
        setup do
          add_response "guernsey"
        end
        should "ask you if your employer pays NI contributions" do
          assert_current_node :employer_paying_ni?
        end

        context "answer yes" do
          setup do
            add_response "yes"
          end
          should "ask are you eligible for SMP" do
            assert_current_node :eligible_for_smp?
          end
          context "answer yes" do
            setup do
              add_response "yes"
            end
            should "take you to SS eligible outcome" do
              assert_current_node :maternity_benefits_eea_entitled_outcome
            end
          end
          context "answer no" do
            setup do
              add_response "no"
            end
            should "take you to can't get SMP but may get MA outcome" do
              assert_current_node :maternity_benefits_maternity_allowance_outcome
            end
          end
        end
        context "answer no" do
          setup do
            add_response "no"
          end
          should "take you to can't get SMP but may get MA outcome" do
            assert_current_node :maternity_benefits_social_security_going_abroad_outcome
          end
        end
      end

      context "answer EEA country" do
        setup do
          add_response "austria"
        end
        should "ask are you working for a UK employer" do
          assert_current_node :working_for_a_uk_employer?
        end
        context "answer yes" do
          setup do
            add_response "yes"
          end
          should "ask if you're eligible for SMP" do
            assert_current_node :eligible_for_smp?
          end
          context "answer yes" do
            setup do
              add_response "yes"
            end
            should "take you to EEA eligible outcome" do
              assert_current_node :maternity_benefits_eea_entitled_outcome
            end
          end
          context "answer no" do
            setup do
              add_response "no"
            end
            should "take you to can't get SMP but may get MA outcome" do
              assert_current_node :maternity_benefits_maternity_allowance_outcome
            end
          end
        end
        context "answer no" do
          setup do
            add_response "no"
          end
          should "take you to the can't get SMP but may get MA outcome" do
            assert_current_node :maternity_benefits_maternity_allowance_outcome
          end
        end
      end

      context "answer SS country" do
        setup do
          add_response "kosovo"
        end
        should "ask if your empoyer is paying NI contributions" do
          assert_current_node :employer_paying_ni?
        end
        context "answer yes" do
          setup do
            add_response "yes"
          end
          should "take you to SMP question" do
            assert_current_node :eligible_for_smp?
          end
          context "answer yes" do
            setup do
              add_response "yes"
            end
            should "take you to EEA entitled outcome" do
              assert_current_node :maternity_benefits_eea_entitled_outcome
            end
          end
          context "answer no" do
            setup do
              add_response "no"
            end
            should "take you to can't get SMP but may get MA outcome" do
              assert_current_node :maternity_benefits_maternity_allowance_outcome
            end
          end
        end
        context "answer no" do
          setup do
            add_response "no"
          end
          should "take you to SS going abroad outcome" do
            assert_current_node :maternity_benefits_social_security_going_abroad_outcome
          end
        end
      end

      context "answer 'other' country" do
        setup do
          add_response "albania"
        end
        should "ask if your empoyer is paying NI contributions" do
          assert_current_node :employer_paying_ni?
        end
        context "answer yes" do
          setup do
            add_response "yes"
          end
          should "take you to SMP question" do
            assert_current_node :eligible_for_smp?
          end
          context "answer yes" do
            setup do
              add_response "yes"
            end
            should "take you to SS entitled outcome" do
              assert_current_node :maternity_benefits_eea_entitled_outcome
            end
          end
          context "answer no" do
            setup do
              add_response "no"
            end
            should "take you to not entitled outcome" do
              assert_current_node :maternity_benefits_maternity_allowance_outcome
            end
          end
        end
        context "answer no" do
          setup do
            add_response "no"
          end
          should "take you to not entitled outcome" do
            assert_current_node :maternity_benefits_not_entitled_outcome
          end
        end
      end
    end

    # Child benefits
    context "answer child benefits" do
      setup do
        add_response "child_benefit"
      end
      should "ask you the country question" do
        assert_current_node :which_country?
      end

      context "answer Guernsey or Jersey" do
        setup do
          add_response "jersey"
        end
        should "take you to SS outcome" do
          assert_current_node :child_benefit_ss_outcome
        end
      end

      context "answer EEA country" do
        setup do
          add_response "austria"
        end

        should "ask you do any of the following apply" do
          assert_current_node :do_either_of_the_following_apply?
        end

        context "selects more than one benefit" do
          setup do
            add_response "incapacity_benefit,state_pension"
          end

          should "take you to the entitled outcome" do
            assert_current_node :child_benefit_entitled_outcome
          end
        end

        context "selects only one benefit" do
          setup do
            add_response "incapacity_benefit"
          end

          should "take you to the entitled outcome" do
            assert_current_node :child_benefit_entitled_outcome
          end
        end

        context "selects at least one invalid benefit" do
          setup do
            add_response "invalid_benefit,state_pension"
          end

          should "get illegal option invalid_benefit error" do
            assert_current_node_is_error "Illegal option invalid_benefit for do_either_of_the_following_apply?"
          end
        end

        context "does not select any benefits" do
          setup do
            add_response "none"
          end

          should "take you to not entitled outcome" do
            assert_current_node :child_benefit_not_entitled_outcome
          end
        end
      end
      context "answer FY country" do
        setup do
          add_response "kosovo"
        end
        should "take you to FY going abroad outcome" do
          assert_current_node :child_benefit_fy_going_abroad_outcome
        end
      end
      context "answer SS country" do
        setup do
          add_response "canada"
        end
        should "take you to SS outcome" do
          assert_current_node :child_benefit_ss_outcome
        end
      end
      context "answer JTU country" do
        setup do
          add_response "jamaica"
        end
        should "take you to JTU outcome" do
          assert_current_node :child_benefit_jtu_outcome
        end
      end
      context "answer other country" do
        setup do
          add_response "albania"
        end
        should "take you to not entitled outcome" do
          assert_current_node :child_benefit_not_entitled_outcome
        end
      end
    end

    # SSP
    context "answer statutory sick pay (SSP)" do
      setup do
        add_response "ssp"
      end
      should "ask which country are you moving to" do
        assert_current_node :which_country?
      end

      context "answer EEA country" do
        setup do
          add_response "austria"
        end
        should "ask you are you working for a UK employer" do
          assert_current_node :working_for_uk_employer_ssp?
        end
        context "answer yes" do
          setup do
            add_response "yes"
          end
          should "take you to the entitled outcome" do
            assert_current_node :ssp_going_abroad_entitled_outcome
          end
        end
        context "answer no" do
          setup do
            add_response "no"
          end
          should "take you to not entitled outcome" do
            assert_current_node :ssp_going_abroad_not_entitled_outcome
          end
        end
      end

      context "answer other country" do
        setup do
          add_response "albania"
        end
        should "ask is your employer paying NI contributions for you" do
          assert_current_node :employer_paying_ni?
        end
        context "answer yes" do
          setup do
            add_response "yes"
          end
          should "take you to the entitled outcome" do
            assert_current_node :ssp_going_abroad_entitled_outcome
          end
        end
        context "answer no" do
          setup do
            add_response "no"
          end
          should "take you to not entitled outcome" do
            assert_current_node :ssp_going_abroad_not_entitled_outcome
          end
        end
      end
    end

    # Tax Credis
    context "answer tax credits" do
      setup do
        add_response "tax_credits"
      end
      should "ask if you or partner is a crown servant or cross-border worker" do
        assert_current_node :eligible_for_tax_credits?
      end
      context "answer crown servant" do
        setup do
          add_response "crown_servant"
        end
        should "take you to crown servant outcome" do
          assert_current_node :tax_credits_crown_servant_outcome
        end
      end
      context "answer cross-border worker" do
        setup do
          add_response "cross_border_worker"
        end
        should "take you to cross-border worker outcome" do
          assert_current_node :tax_credits_cross_border_worker_outcome
        end
      end
      context "answer none of the above" do
        setup do
          add_response "none_of_the_above"
        end
        should "ask how long you're going abroad for" do
          assert_current_node :tax_credits_how_long_abroad?
        end

        context "answer less than a year" do
          setup do
            add_response :tax_credits_up_to_a_year
          end
          should "ask why are you going abroad" do
            assert_current_node :tax_credits_why_going_abroad?
            assert_equal current_state.calculator.why_abroad_question_title, "Why are you going abroad?"
          end
          context "answer holiday" do
            setup do
              add_response "tax_credits_holiday"
            end
            should "take you to the holiday outcome" do
              assert_current_node :tax_credits_holiday_outcome
            end
          end
          context "answer medical treatment" do
            setup do
              add_response "tax_credits_medical_treatment"
            end
            should "take you to medical treatment outcome" do
              assert_current_node :tax_credits_medical_death_outcome
            end
          end
          context "answer family bereavement" do
            setup do
              add_response "tax_credits_death"
            end
            should "take you to family bereavement outcome" do
              assert_current_node :tax_credits_medical_death_outcome
            end
          end
        end
        context "answer more than a year" do
          setup do
            add_response "tax_credits_more_than_a_year"
          end
          should "ask if you have children" do
            assert_current_node :tax_credits_children?
          end
          context "answer no" do
            setup do
              add_response "no"
            end
            should "take you to unlikely outcome" do
              assert_current_node :tax_credits_unlikely_outcome
            end
          end
          context "answer yes" do
            setup do
              add_response "yes"
            end
            should "ask you what country you're moving to" do
              assert_current_node :which_country?
              assert_equal current_state.calculator.country_question_title, "Which country are you moving to?"
            end
            context "answer EEA country" do
              setup do
                add_response "austria"
              end
              should "ask are you claiming any of these benefits" do
                assert_current_node :tax_credits_currently_claiming?
              end

              context "selects at least one tax credit" do
                setup do
                  add_response "widows_benefit"
                end

                should "take you to EEA may qualify outcome" do
                  assert_current_node :tax_credits_eea_entitled_outcome
                end
              end

              context "selects more than one tax credit" do
                setup do
                  add_response "widows_benefit,contribution_based_employment_support_allowance"
                end

                should "take you to EEA may qualify outcome" do
                  assert_current_node :tax_credits_eea_entitled_outcome
                end
              end

              context "selects at least one invalid tax credit benefit" do
                setup do
                  add_response "invalid_tax_credit_benefit,widows_benefit"
                end

                should "get illegal options error" do
                  assert_current_node_is_error "Illegal option invalid_tax_credit_benefit for tax_credits_currently_claiming?"
                end
              end

              context "does not selects any tax credit" do
                setup do
                  add_response "none"
                end

                should "take you to not entitled outcome" do
                  assert_current_node :tax_credits_unlikely_outcome
                end
              end
            end

            context "answer other country" do
              setup do
                add_response "albania"
              end
              should "take you to not entitled outcome" do
                assert_current_node :tax_credits_unlikely_outcome
              end
            end
          end
        end
      end
    end

    # ESA
    context "answer ESA" do
      setup do
        add_response "esa"
      end
      should "ask how long you're going abroad" do
        assert_current_node :esa_how_long_abroad?
      end
      context "answer less than a year for medical treatment" do
        setup do
          add_response "esa_under_a_year_medical"
        end
        should "take you to medical treatment outcome" do
          assert_current_node :esa_going_abroad_under_a_year_medical_outcome
        end
      end
      context "answer less than a year for different reason" do
        setup do
          add_response "esa_under_a_year_other"
        end
        should "take you to different reason outcome" do
          assert_current_node :esa_going_abroad_under_a_year_other_outcome
        end
      end
      context "answers more than a year" do
        setup do
          add_response "esa_more_than_a_year"
        end
        should "ask which country are you moving to" do
          assert_current_node :which_country?
        end
        context "answer EEA country" do
          setup do
            add_response "austria"
          end
          should "take you to EEA outcome" do
            assert_current_node :esa_going_abroad_eea_outcome
          end
        end
        context "answer albania" do
          setup do
            add_response "albania"
          end
          should "take you to other outcome" do
            assert_current_node :esa_going_abroad_other_outcome
          end
        end

        context "answer kosovo" do
          setup do
            add_response "kosovo"
          end
          should "take you to other outcome" do
            assert_current_node :esa_going_abroad_eea_outcome
          end
        end
      end
    end

    # IIDB
    context "answer IIDB" do
      setup do
        add_response "iidb"
      end
      should "ask are you already claiming IIDB" do
        assert_current_node :iidb_already_claiming?
      end

      context "answer no" do
        setup do
          add_response "no"
        end
        should "take you to maybe outcome" do
          assert_current_node :iidb_maybe_outcome
        end
      end
      context "answer yes" do
        setup do
          add_response "yes"
        end
        should "take you to country question" do
          assert_current_node :which_country?
        end
        context "answer Guernsey" do
          setup do
            add_response "guernsey"
          end
          should "take you to SS outcome" do
            assert_current_node :iidb_going_abroad_ss_outcome
          end
        end
        context "answer EEA country" do
          setup do
            add_response "austria"
          end
          should "take you to EEA outcome" do
            assert_current_node :iidb_going_abroad_eea_outcome
          end
        end
        context "answer SS country" do
          setup do
            add_response "kosovo"
          end
          should "take you to SS outcome" do
            assert_current_node :iidb_going_abroad_ss_outcome
          end
        end
        context "answer other country" do
          setup do
            add_response "albania"
          end
          should "take you to other country outcome" do
            assert_current_node :iidb_going_abroad_other_outcome
          end
        end
      end
    end

    # Disability benefits
    context "answer Disability benefits" do
      setup do
        add_response "disability_benefits"
      end
      should "ask how long you're gong abroad for" do
        assert_current_node :db_how_long_abroad?
        assert_equal current_state.calculator.how_long_question_titles, "How long will you be abroad for?"
      end
      context "answer temporarily" do
        setup do
          add_response "temporary"
        end
        should "take you to temporary outcome" do
          assert_current_node :db_going_abroad_temporary_outcome
        end
      end
      context "answer permanently" do
        setup do
          add_response "permanent"
        end
        should "ask which country you are moving to" do
          assert_current_node :which_country?
        end
        context "answer other country" do
          setup do
            add_response "albania"
          end
          should "take you to other country outcome" do
            assert_current_node :db_going_abroad_other_outcome
          end
        end
        context "answer EEA country" do
          setup do
            add_response "austria"
          end
          should "ask you if you or family are getting benefits" do
            assert_current_node :db_claiming_benefits?
          end
          context "answer yes" do
            setup do
              add_response "yes"
            end
            should "take you to EEA outcome" do
              assert_current_node :db_going_abroad_eea_outcome
            end
          end
          context "answer no" do
            setup do
              add_response "no"
            end
            should "take you to other outcome" do
              assert_current_node :db_going_abroad_other_outcome
            end
          end
        end
      end
    end

    # Bereavement benefits
    context "answer bereavement benefits" do
      setup do
        add_response "bereavement_benefits"
      end
      should "take you to the country question" do
        assert_current_node :which_country?
      end
      context "answer Guernsey" do
        setup do
          add_response "guernsey"
        end
        should "take you to the SS outcome" do
          assert_current_node :bb_going_abroad_ss_outcome
        end
      end
      context "answer EEA country" do
        setup do
          add_response "austria"
        end
        should "take you to EEA outcome" do
          assert_current_node :bb_going_abroad_eea_outcome
        end
      end
      context "answer SS country" do
        setup do
          add_response "kosovo"
        end
        should "take you to SS outcome" do
          assert_current_node :bb_going_abroad_ss_outcome
        end
      end
      context "answer other country" do
        setup do
          add_response "albania"
        end
        should "take you to other country outcome" do
          assert_current_node :bb_going_abroad_other_outcome
        end
      end
    end

    # answer Income Support
    context "answer income support" do
      setup do
        add_response "income_support"
      end
      should "ask how long you are going abroad for" do
        assert_current_node :is_how_long_abroad?
      end
      context "answer longer than a year" do
        setup do
          add_response "is_more_than_a_year"
        end
        should "take you to more than a year outcome" do
          assert_current_node :is_more_than_a_year_outcome
        end
      end
      context "answer less than a year for medical reasons" do
        setup do
          add_response "is_under_a_year_medical"
        end
        should "take you to under a year medical reasons outcome" do
          assert_current_node :is_under_a_year_medical_outcome
        end
      end
      context "answers less than a year for other reasons" do
        setup do
          add_response "is_under_a_year_other"
        end

        should "ask you if you'd traveliing with a partner getting IS" do
          assert_current_node :is_claiming_benefits?
        end

        context "selects more than one partner premium" do
          setup do
            add_response "pension_premium,higher_pensioner"
          end

          should "take you to the carry on claiming 4 weeks outcome" do
            assert_current_node :is_claiming_benefits_outcome
          end
        end

        context "selects only one partner premium" do
          setup do
            add_response "higher_pensioner"
          end

          should "take you to the carry on claiming 4 weeks outcome" do
            assert_current_node :is_claiming_benefits_outcome
          end
        end

        context "selects at least an invalid partner premium" do
          setup do
            add_response "invalid_premium,higher_pensioner"
          end

          should "get illegal option invalid_premium error" do
            assert_current_node_is_error "Illegal option invalid_premium for is_claiming_benefits?"
          end
        end

        context "does not select any partner premium" do
          setup do
            add_response "none"
          end

          should "ask if you're getting IS with SSP or are incapable of work" do
            assert_current_node :is_either_of_the_following?
          end

          context "selects at least one possible impairment" do
            setup do
              add_response "too_ill_to_work"
            end
            should "ask if you're going for medical treatment" do
              assert_current_node :is_abroad_for_treatment?
            end
            context "answer yes" do
              setup do
                add_response "yes"
              end
              should "take you to carry on claiming for 4 weeks outcome" do
                assert_current_node :is_abroad_for_treatment_outcome
              end
            end
            context "answer no" do
              setup do
                add_response "no"
              end
              should "ask if you've been unable to work or received SSP" do
                assert_current_node :is_work_or_sick_pay?
              end

              context "selects more than one impairment period" do
                setup do
                  add_response "364_days,196_days"
                end

                should "take you to carry on claiming for 4 weeks outcome" do
                  assert_current_node :is_abroad_for_treatment_outcome
                end
              end

              context "selects at least one impairment period" do
                setup do
                  add_response "364_days"
                end

                should "take you to carry on claiming for 4 weeks outcome" do
                  assert_current_node :is_abroad_for_treatment_outcome
                end
              end

              context "does not select any impairment period" do
                setup do
                  add_response "none"
                end

                should "take you to not eligible outcome" do
                  assert_current_node :is_not_eligible_outcome
                end
              end

              context "selects at least an impairment period" do
                setup do
                  add_response "invalid_impairment_period,196_days"
                end

                should "get illegal option invalid_impairment_period error" do
                  assert_current_node_is_error "Illegal option invalid_impairment_period for is_work_or_sick_pay?"
                end
              end
            end
          end

          context "selects more than one possible impairment" do
            setup do
              add_response "too_ill_to_work,temporarily_incapable_of_work"
            end

            should "ask if you're going for medical treatment" do
              assert_current_node :is_abroad_for_treatment?
            end
          end

          context "selects at least an invalid impairment" do
            setup do
              add_response "invalid_impairment,temporarily_incapable_of_work"
            end

            should "get illegal option invalid_impairment error" do
              assert_current_node_is_error "Illegal option invalid_impairment for is_either_of_the_following?"
            end
          end

          context "does not select any impairment" do
            setup do
              add_response "none"
            end

            should "ask are you one of the following" do
              assert_current_node :is_any_of_the_following_apply?
            end

            context "selects more than one criterion" do
              setup do
                add_response "trades_dispute,appealing_against_decision"
              end

              should "take you to not eligible outcome" do
                assert_current_node :is_not_eligible_outcome
              end
            end

            context "selects only one criterion" do
              setup do
                add_response "trades_dispute"
              end

              should "take you to not eligible outcome" do
                assert_current_node :is_not_eligible_outcome
              end
            end

            context "does not select any criteria" do
              setup do
                add_response "none"
              end

              should "take you to carry on claiming for 4 weeks outcome" do
                assert_current_node :is_abroad_for_treatment_outcome
              end
            end

            context "selects at least an invalid criterion" do
              setup do
                add_response "invalid_criterion,trades_dispute"
              end

              should "get illegal option invalid_criterion error" do
                assert_current_node_is_error "Illegal option invalid_criterion for is_any_of_the_following_apply?"
              end
            end
          end
        end
      end
    end
  end
  # end Going Abroad

  # Already abroad
  context "already abroad" do
    setup do
      add_response "already_abroad"
    end

    should "ask which benefit you're interested in" do
      assert_current_node :which_benefit?
    end
    # JSA
    context "answer JSA" do
      setup do
        add_response "jsa"
      end
      should "Ask which country you are living in" do
        assert_current_node :which_country?
      end
      context "answer Austria" do # EEA country
        setup do
          add_response "austria"
        end
        should "go to JSA EEA already abroad outcome" do
          assert_current_node :jsa_eea_already_abroad_outcome
        end
      end
      context "answer Ireland" do # Ireland
        setup do
          add_response "ireland"
        end
        should "go to JSA EEA already abroad outcome" do
          assert_current_node :jsa_eea_already_abroad_outcome
        end
      end
      context "answer Kosovo" do # SS country
        setup do
          add_response "kosovo"
        end
        should "go to JSA SS social security already abroad outcome" do
          assert_current_node :jsa_social_security_already_abroad_outcome
        end
      end
      context "answer Albania" do # not EEA or SS country
        setup do
          add_response "albania"
        end
        should "Go to JSA not entitled outcome" do
          assert_current_node :jsa_not_entitled_outcome
        end
      end
    end

    # State Pension
    context "answer State Pension" do
      setup do
        add_response "pension"
      end
      should "take you to the pension already abroad outcome" do
        assert_current_node :pension_already_abroad_outcome
      end
    end

    # Maternity benefits
    context "answer Guernsey/Jersey, employer paying NI, eligible for SMP" do
      setup do
        add_response "maternity_benefits"
        add_response "jersey"
        add_response "yes"
        add_response "yes"
      end
      should "take you to SMP entitled outcome" do
        assert_current_node :maternity_benefits_eea_entitled_outcome
      end
    end
    context "answer Guernsey/Jersey, employer paying NI, not eligible for SMP" do
      setup do
        add_response "maternity_benefits"
        add_response "guernsey"
        add_response "yes"
        add_response "no"
      end
      should "take you to SS can't get SMP but may get MA outcome" do
        assert_current_node :maternity_benefits_maternity_allowance_outcome
      end
    end
    context "answer Guernsey/Jersey, employer paying NI" do
      setup do
        add_response "maternity_benefits"
        add_response "jersey"
        add_response "no"
      end
      should "take you to SS can't get SMP but may get MA outcome" do
        assert_current_node :maternity_benefits_social_security_already_abroad_outcome
      end
    end
    context "answer EEA country, working for UK employer, eligible for SMP" do
      setup do
        add_response "maternity_benefits"
        add_response "austria"
        add_response "yes"
        add_response "yes"
      end
      should "take you to SMP entitled outcome" do
        assert_current_node :maternity_benefits_eea_entitled_outcome
      end
    end
    context "answer EEA country, working for UK employer, not eligible for SMP" do
      setup do
        add_response "maternity_benefits"
        add_response "austria"
        add_response "yes"
        add_response "no"
      end
      should "take you to can't get SMP but may get MA outcome" do
        assert_current_node :maternity_benefits_maternity_allowance_outcome
      end
    end
    context "answer EEA country, not working for UK employer" do
      setup do
        add_response "maternity_benefits"
        add_response "austria"
        add_response "no"
      end
      should "take you to can't get SMP but may get MA outcome" do
        assert_current_node :maternity_benefits_maternity_allowance_outcome
      end
    end
    context "answer SS country, employer paying NI, eligible for SMP" do
      setup do
        add_response "maternity_benefits"
        add_response "kosovo"
        add_response "yes"
        add_response "yes"
      end
      should "take you to can't get SMP but may get MA outcome" do
        assert_current_node :maternity_benefits_eea_entitled_outcome
      end
    end
    context "answer SS country, employer paying NI, not eligible for SMP" do
      setup do
        add_response "maternity_benefits"
        add_response "kosovo"
        add_response "yes"
        add_response "no"
      end
      should "take you to can't get SMP but may get MA outcome" do
        assert_current_node :maternity_benefits_maternity_allowance_outcome
      end
    end
    context "answer SS country, employer not paying NI" do
      setup do
        add_response "maternity_benefits"
        add_response "kosovo"
        add_response "no"
      end
      should "take you to can't get SMP but may get MA outcome" do
        assert_current_node :maternity_benefits_social_security_already_abroad_outcome
      end
    end
    context "answer other country, employer paying NI, eligible for SMP" do
      setup do
        add_response "maternity_benefits"
        add_response "albania"
        add_response "yes"
        add_response "yes"
      end
      should "take you to can't get SMP but may get MA outcome" do
        assert_current_node :maternity_benefits_eea_entitled_outcome
      end
    end
    context "answer other country, employer paying NI, not eligible for SMP" do
      setup do
        add_response "maternity_benefits"
        add_response "albania"
        add_response "yes"
        add_response "no"
      end
      should "take you to can't get SMP but may get MA outcome" do
        assert_current_node :maternity_benefits_maternity_allowance_outcome
      end
    end
    context "answer other country, employer not paying NI" do
      setup do
        add_response "maternity_benefits"
        add_response "albania"
        add_response "no"
      end
      should "take you to not entitled outcome" do
        assert_current_node :maternity_benefits_not_entitled_outcome
      end
    end

    # Child benefits
    context "answer Guernsey/Jersey and child benefits" do
      setup do
        add_response "child_benefit"
        add_response "jersey"
      end
      should "take you to which country question" do
        assert_current_node :child_benefit_ss_outcome
      end
    end
    context "answer EEA country, paying NI in the UK" do
      setup do
        add_response "child_benefit"
        add_response "austria"
        add_response "state_pension"
      end
      should "take you to entitled outcome" do
        assert_current_node :child_benefit_entitled_outcome
      end
    end
    context "answer EEA country, not paying NI in the UK, not receiving benefits" do
      setup do
        add_response "child_benefit"
        add_response "austria"
        add_response "none"
      end
      should "take you to not entitled outcome" do
        assert_current_node :child_benefit_not_entitled_outcome
      end
    end
    context "answer FY country" do
      setup do
        add_response "child_benefit"
        add_response "kosovo"
      end
      should "take you to FY already abroad outcome" do
        assert_current_node :child_benefit_fy_already_abroad_outcome
      end
    end
    context "answer SS country" do
      setup do
        add_response "child_benefit"
        add_response "canada"
      end
      should "take you to SS outcome" do
        assert_current_node :child_benefit_ss_outcome
      end
    end
    context "answer JTU country" do
      setup do
        add_response "child_benefit"
        add_response "jamaica"
      end
      should "take you to JTU outcome" do
        assert_current_node :child_benefit_jtu_outcome
      end
    end

    # Statutory Sick Pay (SSP)
    context "answer EEA country, working for a UK employer" do
      setup do
        add_response "ssp"
        add_response "austria"
        add_response "yes"
      end
      should "take you to entitled outcome" do
        assert_current_node :ssp_already_abroad_entitled_outcome
      end
    end
    context "answer EEA country, not working for a UK employer" do
      setup do
        add_response "ssp"
        add_response "austria"
        add_response "no"
      end
      should "take you to entitled outcome" do
        assert_current_node :ssp_already_abroad_not_entitled_outcome
      end
    end
    context "answer other country, employer paying NI" do
      setup do
        add_response "ssp"
        add_response "albania"
        add_response "yes"
      end
      should "take you to entitled outcome" do
        assert_current_node :ssp_already_abroad_entitled_outcome
      end
    end
    context "answer other country, employer not paying NI" do
      setup do
        add_response "ssp"
        add_response "albania"
        add_response "no"
      end
      should "take you to entitled outcome" do
        assert_current_node :ssp_already_abroad_not_entitled_outcome
      end
    end

    # Tax Credits
    context "answer crown servant" do
      setup do
        add_response "tax_credits"
        add_response "crown_servant"
      end
      should "take you to crown servant outcome" do
        assert_current_node :tax_credits_crown_servant_outcome
      end
    end
    context "answer cross-border worker" do
      setup do
        add_response "tax_credits"
        add_response "cross_border_worker"
      end
      should "take you to cross-border worker outcome" do
        assert_current_node :tax_credits_cross_border_worker_outcome
      end
    end
    context "not crown or cross, abroad less than a year, holiday" do
      setup do
        add_response "tax_credits"
        add_response "none_of_the_above"
        add_response "tax_credits_up_to_a_year"
        add_response "tax_credits_holiday"
      end
      should "take you to the holiday outcome" do
        assert_current_node :tax_credits_holiday_outcome
      end
    end
    context "not crown or cross, abroad less than a year, medical treatment" do
      setup do
        add_response "tax_credits"
        add_response "none_of_the_above"
        add_response "tax_credits_up_to_a_year"
        add_response "tax_credits_medical_treatment"
      end
      should "take you to the medical treatment outcome" do
        assert_current_node :tax_credits_medical_death_outcome
      end
    end
    context "not crown or cross, abroad less than a year, family bereavement" do
      setup do
        add_response "tax_credits"
        add_response "none_of_the_above"
        add_response "tax_credits_up_to_a_year"
        add_response "tax_credits_death"
      end
      should "take you to the family bereavment outcome" do
        assert_current_node :tax_credits_medical_death_outcome
      end
    end
    context "not crown or cross, abroad more than a year, no children" do
      setup do
        add_response "tax_credits"
        add_response "none_of_the_above"
        add_response "tax_credits_more_than_a_year"
        add_response "no"
      end
      should "take you to unlikely outcome" do
        assert_current_node :tax_credits_unlikely_outcome
      end
    end
    context "not crown or cross, abroad more than a year, children, EEA country, benefits" do
      setup do
        add_response "tax_credits"
        add_response "none_of_the_above"
        add_response "tax_credits_more_than_a_year"
        add_response "yes"
        add_response "austria"
        add_response "widows_benefit"
      end
      should "take you to entitled outcome" do
        assert_current_node :tax_credits_eea_entitled_outcome
      end
    end
    context "not crown or cross, abroad more than a year, children, EEA country, no benefits" do
      setup do
        add_response "tax_credits"
        add_response "none_of_the_above"
        add_response "tax_credits_more_than_a_year"
        add_response "yes"
        add_response "austria"
        add_response "none"
      end
      should "take you to unlikely outcome" do
        assert_current_node :tax_credits_unlikely_outcome
      end
    end
    context "not crown or cross, abroad more than a year, children, other country" do
      setup do
        add_response "tax_credits"
        add_response "none_of_the_above"
        add_response "tax_credits_more_than_a_year"
        add_response "yes"
        add_response "albania"
      end
      should "take you to unlikely outcome" do
        assert_current_node :tax_credits_unlikely_outcome
      end
    end

    # ESA
    context "living abroad for less than a year medical reasons" do
      setup do
        add_response "esa"
        add_response "esa_under_a_year_medical"
      end
      should "take you to less than a year medical outcome" do
        assert_current_node :esa_already_abroad_under_a_year_medical_outcome
      end
    end
    context "living abroad for less than a year other reasons" do
      setup do
        add_response "esa"
        add_response "esa_under_a_year_other"
      end
      should "take you to less than a year medical outcome" do
        assert_current_node :esa_already_abroad_under_a_year_other_outcome
      end
    end
    context "living abroad for more than a year, EEA country" do
      setup do
        add_response "esa"
        add_response "esa_more_than_a_year"
        add_response "austria"
      end
      should "take you to EEA country outcome" do
        assert_current_node :esa_already_abroad_eea_outcome
      end
    end
    context "living abroad for more than a year, other country" do
      setup do
        add_response "esa"
        add_response "esa_more_than_a_year"
        add_response "albania"
      end
      should "take you to other country outcome" do
        assert_current_node :esa_already_abroad_other_outcome
      end
    end
    context "living abroad for more than a year, former yugoslavia country" do
      setup do
        add_response "esa"
        add_response "esa_more_than_a_year"
        add_response "kosovo"
      end
      should "take you to former yugoslavia outcome" do
        assert_current_node :esa_already_abroad_ss_outcome
      end
    end

    context "living abroad for more than a year, jersey" do
      setup do
        add_response "esa"
        add_response "esa_more_than_a_year"
        add_response "jersey"
      end
      should "take you to former yugoslavia outcome" do
        assert_current_node :esa_already_abroad_ss_outcome
      end
    end

    # IIDB
    context "answer not claiming IIDB" do
      setup do
        add_response "iidb"
        add_response "no"
      end
      should "take you to maybe outcome" do
        assert_current_node :iidb_maybe_outcome
      end
    end
    context "answer already claiming, Guernsey" do
      setup do
        add_response "iidb"
        add_response "yes"
        add_response "jersey"
      end
      should "take you to SS outcome" do
        assert_current_node :iidb_already_abroad_ss_outcome
      end
    end
    context "answer already claiming, Austria" do
      setup do
        add_response "iidb"
        add_response "yes"
        add_response "austria"
      end
      should "take you to EEA outcome" do
        assert_current_node :iidb_already_abroad_eea_outcome
      end
    end
    context "answer already claiming, Kosovo" do
      setup do
        add_response "iidb"
        add_response "yes"
        add_response "kosovo"
      end
      should "take you to SS outcome" do
        assert_current_node :iidb_already_abroad_ss_outcome
      end
    end
    context "answer already claiming, Albania" do
      setup do
        add_response "iidb"
        add_response "yes"
        add_response "albania"
      end
      should "take you to other outcome" do
        assert_current_node :iidb_already_abroad_other_outcome
      end
    end

    # Disability benefits
    context "answer going abroad temporarily" do
      setup do
        add_response "disability_benefits"
        add_response "temporary"
      end
      should "take you to temporary outcome" do
        assert_current_node :db_already_abroad_temporary_outcome
      end
    end
    context "answer going abroad permanently, other country" do
      setup do
        add_response "disability_benefits"
        add_response "permanent"
        add_response "albania"
      end
      should "take you to other country outcome" do
        assert_current_node :db_already_abroad_other_outcome
      end
    end
    context "answer going abroad permanently, EEA country, no benefits" do
      setup do
        add_response "disability_benefits"
        add_response "permanent"
        add_response "austria"
        add_response "no"
      end
      should "take you to other country outcome" do
        assert_current_node :db_already_abroad_other_outcome
      end
    end
    context "answer going abroad permanently, EEA country, with benefits" do
      setup do
        add_response "disability_benefits"
        add_response "permanent"
        add_response "austria"
        add_response "yes"
      end
      should "take you to other country outcome" do
        assert_current_node :db_already_abroad_eea_outcome
      end
    end

    # Bereavement benefits
    context "answer Guernsey/Jersey and bereavement benefits" do
      setup do
        add_response "bereavement_benefits"
        add_response "guernsey"
      end
      should "take you to SS outcome" do
        assert_current_node :bb_already_abroad_ss_outcome
      end
    end
    context "answer EEA country" do
      setup do
        add_response "bereavement_benefits"
        add_response "austria"
      end
      should "take you to EEA outcome" do
        assert_current_node :bb_already_abroad_eea_outcome
      end
    end
    context "answer SS country" do
      setup do
        add_response "bereavement_benefits"
        add_response "kosovo"
      end
      should "take you to SS outcome" do
        assert_current_node :bb_already_abroad_ss_outcome
      end
    end
    context "answer other country" do
      setup do
        add_response "bereavement_benefits"
        add_response "albania"
      end
      should "take you to other country outcome" do
        assert_current_node :bb_already_abroad_other_outcome
      end
    end

    # Income support
    context "answer income support" do
      setup do
        add_response "income_support"
      end
      should "take you to already abroad outcome" do
        assert_current_node :is_already_abroad_outcome
      end
    end
  end # end Already Abroad
end
