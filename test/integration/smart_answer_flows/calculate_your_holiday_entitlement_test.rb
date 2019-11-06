require_relative "../../test_helper"
require_relative "flow_test_helper"

require "smart_answer_flows/calculate-your-holiday-entitlement"

class CalculateYourHolidayEntitlementTest < ActiveSupport::TestCase
  include FlowTestHelper

  setup do
    setup_for_testing_flow SmartAnswer::CalculateYourHolidayEntitlementFlow
    @stubbed_calculator = SmartAnswer::Calculators::HolidayEntitlement.new
  end

  should "ask what the basis of the calculation is" do
    assert_current_node :basis_of_calculation?
  end

  context "for hours worked per week" do
    setup do
      add_response "hours-worked-per-week"
    end
    should "ask the time period for the calculation" do
      assert_current_node :calculation_period?
    end
    context "answer full leave year" do
      setup do
        add_response "full-year"
      end
      should "ask the number of hours worked per week" do
        assert_current_node :how_many_hours_per_week?
      end
      context "answer 40 hours" do
        setup do
          add_response "40"
        end
        should "ask the number of days worked per week" do
          assert_current_node :how_many_days_per_week_for_hours?
        end
        context "answer 5 days" do
          setup do
            add_response "5"
          end
          should "calculate the holiday entitlement" do
            SmartAnswer::Calculators::HolidayEntitlement
              .expects(:new)
              .with(
                hours_per_week: 40.0,
                working_days_per_week: 5.0,
                start_date: nil,
                leaving_date: nil,
                leave_year_start_date: nil,
              ).returns(@stubbed_calculator)
            @stubbed_calculator.expects(:full_time_part_time_hours).returns(224.0)

            assert_current_node :hours_per_week_done
            assert_state_variable "holiday_entitlement_hours", 224
          end
        end
      end
    end
    context "answer starting part way through the leave year" do
      setup do
        add_response "starting"
      end
      should "ask for the employment start date" do
        assert_current_node :what_is_your_starting_date?
      end
      context "answer June 1st 2019" do
        setup do
          add_response "2019-06-01"
        end
        should "ask when the leave year started" do
          assert_current_node :when_does_your_leave_year_start?
        end
        context "answer Jan 1st 2019" do
          setup do
            add_response "2019-01-01"
          end
          should "ask the number of hours worked per week" do
            assert_current_node :how_many_hours_per_week?
          end
          context "answer 40 hours" do
            setup do
              add_response "40"
            end
            should "ask the number of days worked per week" do
              assert_current_node :how_many_days_per_week_for_hours?
            end
            context "answer 5 days" do
              setup do
                add_response "5"
              end
              should "calculate the holiday entitlement" do
                SmartAnswer::Calculators::HolidayEntitlement.
                  expects(:new).
                  with(
                    hours_per_week: 40.0,
                    working_days_per_week: 5,
                    start_date: Date.parse("2019-06-01"),
                    leaving_date: nil,
                    leave_year_start_date: Date.parse("2019-01-01"),
                  ).
                  returns(@stubbed_calculator)
                @stubbed_calculator.expects(:full_time_part_time_hours).returns(132.0)

                assert_current_node :hours_per_week_done
                assert_state_variable "holiday_entitlement_hours", 132
              end
            end
          end
        end
      end
    end

    context "answer leaving part way through the leave year" do
      setup do
        add_response "leaving"
      end
      should "ask for the employment end date" do
        assert_current_node :what_is_your_leaving_date?
      end
      context "answer June 1st 2019" do
        setup do
          add_response "2019-06-01"
        end
        should "ask when the leave year started" do
          assert_current_node :when_does_your_leave_year_start?
        end
        context "answer Jan 1st 2019" do
          setup do
            add_response "2019-01-01"
          end
          should "ask the number of hours worked per week" do
            assert_current_node :how_many_hours_per_week?
          end
          context "answer 40 hours" do
            setup do
              add_response "40"
            end
            should "ask the number of days worked per week" do
              assert_current_node :how_many_days_per_week_for_hours?
            end
            context "answer 5 days" do
              setup do
                add_response "5"
              end
              should "calculate the holiday entitlement" do
                SmartAnswer::Calculators::HolidayEntitlement.
                  expects(:new).
                  with(
                    hours_per_week: 40,
                    working_days_per_week: 5,
                    start_date: nil,
                    leaving_date: Date.parse("2019-06-01"),
                    leave_year_start_date: Date.parse("2019-01-01"),
                  ).
                  returns(@stubbed_calculator)
                @stubbed_calculator.expects(:full_time_part_time_hours).returns(93.29)

                assert_current_node :hours_per_week_done
                assert_state_variable "holiday_entitlement_hours", 93
              end
            end
          end
        end
      end
    end

    context "starting and leaving within a leave year" do
      setup do
        add_response "starting-and-leaving"
      end
      should "ask for the employment start date" do
        assert_current_node :what_is_your_starting_date?
      end
      context "answer 'Jan 20th 2019'" do
        setup do
          add_response "2019-01-20"
        end
        should "ask for the employment end date" do
          assert_current_node :what_is_your_leaving_date?
        end
        context "answer 'July 18th 2019'" do
          setup do
            add_response "2019-07-18"
          end
          should "ask the number of hours worked per week" do
            assert_current_node :how_many_hours_per_week?
          end
          context "answer 40 hours" do
            setup do
              add_response "40"
            end
            should "ask the number of days worked per week" do
              assert_current_node :how_many_days_per_week_for_hours?
            end
            context "answer 5 days" do
              setup do
                add_response "5"
              end
              should "calculate the holiday entitlement" do
                SmartAnswer::Calculators::HolidayEntitlement
                  .expects(:new)
                  .with(
                    hours_per_week: 40,
                    working_days_per_week: 5,
                    start_date: Date.parse("2019-01-20"),
                    leaving_date: Date.parse("2019-07-18"),
                    leave_year_start_date: nil,
                  ).returns(@stubbed_calculator)
                @stubbed_calculator.expects(:full_time_part_time_hours).returns(110.47)

                assert_current_node :hours_per_week_done
                assert_state_variable "holiday_entitlement_hours", 110
              end
            end
          end
        end
      end
    end
  end # hours-worked-per-week

  context "for compressed hours" do
    setup do
      add_response "compressed-hours"
    end
    should "ask the time period for the calculation" do
      assert_current_node :calculation_period?
    end
    context "answer full leave year" do
      setup do
        add_response "full-year"
      end
      should "ask the number of hours worked per week" do
        assert_current_node :how_many_hours_per_week?
      end
      context "answer 40 hours" do
        setup do
          add_response "40"
        end
        should "ask the number of days worked per week" do
          assert_current_node :how_many_days_per_week_for_hours?
        end
        context "answer 5 days" do
          setup do
            add_response "5"
          end
          should "calculate the holiday entitlement" do
            assert_current_node :compressed_hours_done
            assert_state_variable "holiday_entitlement_hours", 224
            assert_state_variable "holiday_entitlement_minutes", 0
            assert_state_variable "hours_daily", 8
            assert_state_variable "minutes_daily", 0
          end
        end
      end
    end

    context "answer starting part way through the leave year" do
      setup do
        add_response "starting"
      end
      should "ask for the employment start date" do
        assert_current_node :what_is_your_starting_date?
      end
      context "answer June 1st 2019" do
        setup do
          add_response "2019-06-01"
        end
        should "ask when the leave year started" do
          assert_current_node :when_does_your_leave_year_start?
        end
        context "answer Jan 1st 2019" do
          setup do
            add_response "2019-01-01"
          end
          should "ask the number of hours worked per week" do
            assert_current_node :how_many_hours_per_week?
          end
          context "answer 40 hours" do
            setup do
              add_response "40"
            end
            should "ask the number of days worked per week" do
              assert_current_node :how_many_days_per_week_for_hours?
            end
            context "answer 5 days" do
              setup do
                add_response "5"
              end
              should "calculate the holiday entitlement" do
                assert_current_node :compressed_hours_done
                assert_state_variable "holiday_entitlement_hours", 132
                assert_state_variable "holiday_entitlement_minutes", 0
                assert_state_variable "hours_daily", 8
                assert_state_variable "minutes_daily", 0
              end
            end
          end
        end
      end
    end

    context "answer leaving part way through the leave year" do
      setup do
        add_response "leaving"
      end
      should "ask for the employment end date" do
        assert_current_node :what_is_your_leaving_date?
      end
      context "answer June 1st 2019" do
        setup do
          add_response "2019-06-01"
        end
        should "ask when the leave year started" do
          assert_current_node :when_does_your_leave_year_start?
        end
        context "answer Jan 1st 2019" do
          setup do
            add_response "2019-01-01"
          end
          should "ask the number of hours worked per week" do
            assert_current_node :how_many_hours_per_week?
          end
          context "answer 40 hours" do
            setup do
              add_response "40"
            end
            should "ask the number of days worked per week" do
              assert_current_node :how_many_days_per_week_for_hours?
            end
            context "answer 5 days" do
              setup do
                add_response "5"
              end
              should "calculate the holiday entitlement" do
                assert_current_node :compressed_hours_done
                assert_state_variable "holiday_entitlement_hours", 93
                assert_state_variable "holiday_entitlement_minutes", 17
                assert_state_variable "hours_daily", 8
                assert_state_variable "minutes_daily", 0
              end
            end
          end
        end
      end
    end

    context "starting and leaving within a leave year" do
      setup do
        add_response "starting-and-leaving"
      end
      should "ask for the employment start date" do
        assert_current_node :what_is_your_starting_date?
      end
      context "answer 'Jan 20th 2019'" do
        setup do
          add_response "2019-01-20"
        end
        should "ask for the employment end date" do
          assert_current_node :what_is_your_leaving_date?
        end
        context "answer 'July 18th 2019'" do
          setup do
            add_response "2019-07-18"
          end
          should "ask the number of hours worked per week" do
            assert_current_node :how_many_hours_per_week?
          end
          context "answer 40 hours" do
            setup do
              add_response "40"
            end
            should "ask the number of days worked per week" do
              assert_current_node :how_many_days_per_week_for_hours?
            end
            context "answer 5 days" do
              setup do
                add_response "5"
              end
              should "calculate the holiday entitlement" do
                assert_current_node :compressed_hours_done
                assert_state_variable "holiday_entitlement_hours", 110
                assert_state_variable "holiday_entitlement_minutes", 28
                assert_state_variable "hours_daily", 8
                assert_state_variable "minutes_daily", 0
              end
            end
          end
        end
      end
    end
  end # compressed-hours

  context "irregular hours" do
    setup do
      add_response "irregular-hours"
    end
    should "ask the time period for the calculation" do
      assert_current_node :calculation_period?
    end

    context "answer full leave year" do
      setup do
        add_response "full-year"
      end
      should "calculate the holiday entitlement" do
        SmartAnswer::Calculators::HolidayEntitlement
          .expects(:new)
          .with(
            start_date: nil,
            leaving_date: nil,
            leave_year_start_date: nil
          ).returns(@stubbed_calculator)
        @stubbed_calculator.expects(:formatted_full_time_part_time_weeks).returns("5.6")

        assert_state_variable "holiday_entitlement", "5.6"
        assert_current_node :irregular_and_annualised_done
      end
    end

    context "answer starting part way through the leave year" do
      setup do
        add_response "starting"
      end
      should "ask for the employment start date" do
        assert_current_node :what_is_your_starting_date?
      end
      context "answer June 1st this year" do
        setup do
          add_response "#{Date.today.year}-06-01"
        end
        should "ask when the leave year started" do
          assert_current_node :when_does_your_leave_year_start?
        end
        context "answer Jan 1st this year" do
          setup do
            add_response "#{Date.today.year}-01-01"
          end
          should "calculate the holiday entitlement" do
            SmartAnswer::Calculators::HolidayEntitlement.
              expects(:new).
              with(
                start_date: Date.parse("#{Date.today.year}-06-01"),
                leaving_date: nil,
                leave_year_start_date: Date.parse("#{Date.today.year}-01-01"),
              ).returns(@stubbed_calculator)
            @stubbed_calculator.expects(:formatted_full_time_part_time_weeks).returns("3.27")

            assert_current_node :irregular_and_annualised_done
            assert_state_variable "holiday_entitlement", "3.27"
          end
        end
      end
    end

    context "answer leaving part way through the leave year" do
      setup do
        add_response "leaving"
      end
      should "ask for the employment end date" do
        assert_current_node :what_is_your_leaving_date?
      end
      context "answer June 1st this year" do
        setup do
          add_response "#{Date.today.year}-06-01"
        end
        should "ask when the leave year started" do
          assert_current_node :when_does_your_leave_year_start?
        end
        context "answer Jan 01 this year" do
          setup do
            add_response "#{Date.today.year}-01-01"
          end

          should "calculate the holiday entitlement" do
            SmartAnswer::Calculators::HolidayEntitlement.
              expects(:new).
              with(
                start_date: nil,
                leaving_date: Date.parse("#{Date.today.year}-06-01"),
                leave_year_start_date: Date.parse("#{Date.today.year}-01-01"),
              ).returns(@stubbed_calculator)
            @stubbed_calculator.expects(:formatted_full_time_part_time_weeks).returns("2.34")

            assert_state_variable "holiday_entitlement", "2.34"
            assert_current_node :irregular_and_annualised_done
          end
        end
      end
    end

    context "starting and leaving within a leave year" do
      setup do
        add_response "starting-and-leaving"
      end
      should "ask what was the employment start date" do
        assert_current_node :what_is_your_starting_date?
      end
      context "answer Jan 20th this year" do
        setup do
          add_response "#{Date.today.year}-01-20"
        end
        should "ask what date employment finished" do
          assert_current_node :what_is_your_leaving_date?
        end
        context "answer June 18th this year" do
          setup do
            add_response "#{Date.today.year}-07-18"
          end
          should "calculate the holiday entitlement" do
            SmartAnswer::Calculators::HolidayEntitlement
              .expects(:new)
              .with(
                start_date: Date.parse("#{Date.today.year}-01-20"),
                leaving_date: Date.parse("#{Date.today.year}-07-18"),
                leave_year_start_date: nil,
              ).returns(@stubbed_calculator)
            @stubbed_calculator.expects(:formatted_full_time_part_time_weeks).returns("2.77")

            assert_state_variable "holiday_entitlement", "2.77"
            assert_current_node :irregular_and_annualised_done
          end
        end
      end
    end
  end # irregular hours

  context "annualised hours" do
    setup do
      add_response "annualised-hours"
    end
    should "ask the time period for the calculation" do
      assert_current_node :calculation_period?
    end

    context "answer full leave year" do
      setup do
        add_response "full-year"
      end
      should "calculate the holiday entitlement" do
        SmartAnswer::Calculators::HolidayEntitlement
          .expects(:new)
          .with(
            start_date: nil,
            leaving_date: nil,
            leave_year_start_date: nil
          ).returns(@stubbed_calculator)
        @stubbed_calculator.expects(:formatted_full_time_part_time_weeks).returns("5.6")

        assert_state_variable "holiday_entitlement", "5.6"
        assert_current_node :irregular_and_annualised_done
      end
    end

    context "answer starting part way through the leave year" do
      setup do
        add_response "starting"
      end
      should "ask for the employment start date" do
        assert_current_node :what_is_your_starting_date?
      end
      context "answer June 1st this year" do
        setup do
          add_response "#{Date.today.year}-06-01"
        end
        should "ask when the leave year started" do
          assert_current_node :when_does_your_leave_year_start?
        end
        context "answer Jan 1st this year" do
          setup do
            add_response "#{Date.today.year}-01-01"
          end
          should "calculate the holiday entitlement" do
            SmartAnswer::Calculators::HolidayEntitlement.
              expects(:new).
              with(
                start_date: Date.parse("#{Date.today.year}-06-01"),
                leaving_date: nil,
                leave_year_start_date: Date.parse("#{Date.today.year}-01-01"),
              ).returns(@stubbed_calculator)
            @stubbed_calculator.expects(:formatted_full_time_part_time_weeks).returns("3.27")

            assert_current_node :irregular_and_annualised_done
            assert_state_variable "holiday_entitlement", "3.27"
          end
        end
      end
    end

    context "answer leaving part way through the leave year" do
      setup do
        add_response "leaving"
      end
      should "ask for the employment end date" do
        assert_current_node :what_is_your_leaving_date?
      end
      context "answer June 1st this year" do
        setup do
          add_response "#{Date.today.year}-06-01"
        end
        should "ask when the leave year started" do
          assert_current_node :when_does_your_leave_year_start?
        end
        context "answer Jan 01 this year" do
          setup do
            add_response "#{Date.today.year}-01-01"
          end

          should "calculate the holiday entitlement" do
            SmartAnswer::Calculators::HolidayEntitlement.
              expects(:new).
              with(
                start_date: nil,
                leaving_date: Date.parse("#{Date.today.year}-06-01"),
                leave_year_start_date: Date.parse("#{Date.today.year}-01-01"),
              ).returns(@stubbed_calculator)
            @stubbed_calculator.expects(:formatted_full_time_part_time_weeks).returns("2.34")

            assert_state_variable "holiday_entitlement", "2.34"
            assert_current_node :irregular_and_annualised_done
          end
        end
      end
    end

    context "starting and leaving within a leave year" do
      setup do
        add_response "starting-and-leaving"
      end
      should "ask what was the employment start date" do
        assert_current_node :what_is_your_starting_date?
      end
      context "answer Jan 20th this year" do
        setup do
          add_response "#{Date.today.year}-01-20"
        end
        should "ask what date employment finished" do
          assert_current_node :what_is_your_leaving_date?
        end
        context "answer June 18th this year" do
          setup do
            add_response "#{Date.today.year}-07-18"
          end
          should "calculate the holiday entitlement" do
            SmartAnswer::Calculators::HolidayEntitlement
              .expects(:new)
              .with(
                start_date: Date.parse("#{Date.today.year}-01-20"),
                leaving_date: Date.parse("#{Date.today.year}-07-18"),
                leave_year_start_date: nil,
              ).returns(@stubbed_calculator)
            @stubbed_calculator.expects(:formatted_full_time_part_time_weeks).returns("2.77")

            assert_state_variable "holiday_entitlement", "2.77"
            assert_current_node :irregular_and_annualised_done
          end
        end
      end
    end
  end #annualised hours

  context "shift worker" do
    setup do
      add_response "shift-worker"
    end

    should "ask how long you're working in shifts" do
      assert_current_node :shift_worker_basis?
    end

    context "answer full year year" do
      setup do
        add_response "full-year"
      end

      should "ask how many hours in each shift" do
        assert_current_node :shift_worker_hours_per_shift?
      end
      context "answer 6 hours" do
        setup do
          add_response "6"
        end
        should "ask how many shifts per shift pattern" do
          assert_current_node :shift_worker_shifts_per_shift_pattern?
        end
        context "answer 8 shifts" do
          setup do
            add_response "8"
          end
          should "ask how many days per shift pattern" do
            assert_current_node :shift_worker_days_per_shift_pattern?
          end
          context "answer 14 days" do
            setup do
              add_response "14"
            end
            should "calculate the holiday entitlement" do
              SmartAnswer::Calculators::HolidayEntitlement
                .expects(:new)
                .with(
                  start_date: nil,
                  leaving_date: nil,
                  leave_year_start_date: nil,
                  shifts_per_shift_pattern: 8,
                  days_per_shift_pattern: 14,
                ).returns(@stubbed_calculator)
              @stubbed_calculator.expects(:rounded_shift_entitlement).returns(22.40)

              assert_current_node :shift_worker_done

              assert_state_variable :hours_per_shift, 6
              assert_state_variable :shifts_per_shift_pattern, 8
              assert_state_variable :days_per_shift_pattern, 14
              assert_state_variable :holiday_entitlement_shifts, 22.40
            end
          end
        end
      end
    end # full year

    context "starting this year" do
      setup do
        add_response "starting"
      end

      should "ask your start date" do
        assert_current_node :what_is_your_starting_date?
      end

      context "with a date" do
        setup do
          add_response "#{Date.today.year}-02-16"
        end

        should "ask when your leave year starts" do
          assert_current_node :when_does_your_leave_year_start?
        end

        context "with a leave year start date" do
          setup do
            add_response "#{Date.today.year}-07-01"
          end

          should "ask how many hours in each shift" do
            assert_current_node :shift_worker_hours_per_shift?
          end

          should "ask how many shifts per shift pattern" do
            add_response "8"
            assert_current_node :shift_worker_shifts_per_shift_pattern?
          end

          should "ask how many days per shift pattern" do
            add_response "8"
            add_response "4"
            assert_current_node :shift_worker_days_per_shift_pattern?
          end

          should "be done when all entered" do
            add_response "7.5"
            add_response "4"
            add_response "8"

            SmartAnswer::Calculators::HolidayEntitlement
              .expects(:new)
              .with(
                start_date: Date.parse("#{Date.today.year}-02-16"),
                leaving_date: nil,
                leave_year_start_date: Date.parse("#{Date.today.year}-07-01"),
                hours_per_shift: 7.5,
                shifts_per_shift_pattern: 4,
                days_per_shift_pattern: 8,
              ).returns(@stubbed_calculator)
            @stubbed_calculator.expects(:formatted_shift_entitlement).returns("some shifts")

            assert_current_node :shift_worker_done

            assert_state_variable :hours_per_shift, "7.5"
            assert_state_variable :shifts_per_shift_pattern, 4
            assert_state_variable :days_per_shift_pattern, 8

            assert_state_variable :holiday_entitlement_shifts, "some shifts"
          end
        end # with a leave year start date
      end # with a date
    end # starting this year

    context "leaving this year" do
      setup do
        add_response "leaving"
      end

      should "ask your leaving date" do
        assert_current_node :what_is_your_leaving_date?
      end

      context "with a date" do
        setup do
          add_response "#{Date.today.year}-02-16"
        end

        should "ask when your leave year starts" do
          assert_current_node :when_does_your_leave_year_start?
        end

        context "with a leave year start date" do
          setup do
            add_response "#{Date.today.year}-08-01"
          end

          should "ask how many hours in each shift" do
            assert_current_node :shift_worker_hours_per_shift?
          end

          should "ask how many shifts per shift pattern" do
            add_response "8"
            assert_current_node :shift_worker_shifts_per_shift_pattern?
          end

          should "ask how many days per shift pattern" do
            add_response "8"
            add_response "4"
            assert_current_node :shift_worker_days_per_shift_pattern?
          end

          should "be done when all entered" do
            add_response "7"
            add_response "4"
            add_response "8"

            SmartAnswer::Calculators::HolidayEntitlement
              .expects(:new)
              .with(
                start_date: nil,
                leaving_date: Date.parse("#{Date.today.year}-02-16"),
                leave_year_start_date: Date.parse("#{Date.today.year}-08-01"),
                hours_per_shift: 7,
                shifts_per_shift_pattern: 4,
                days_per_shift_pattern: 8,
              ).returns(@stubbed_calculator)
            @stubbed_calculator.expects(:formatted_shift_entitlement).returns("some shifts")

            assert_current_node :shift_worker_done

            assert_state_variable :hours_per_shift, "7"
            assert_state_variable :shifts_per_shift_pattern, 4
            assert_state_variable :days_per_shift_pattern, 8

            assert_state_variable :holiday_entitlement_shifts, "some shifts"
          end
        end # with a leave year start date
      end # with a date
    end # leaving this year

    context "starting and leaving this year" do
      setup do
        add_response "starting-and-leaving"
      end

      should "ask your start date" do
        assert_current_node :what_is_your_starting_date?
      end

      context "with a date" do
        setup do
          add_response "#{Date.today.year}-02-16"
        end

        should "ask your leave date" do
          assert_current_node :what_is_your_leaving_date?
        end

        context "with a leaving date" do
          setup do
            add_response "#{Date.today.year}-08-01"
          end

          should "ask how many hours in each shift" do
            assert_current_node :shift_worker_hours_per_shift?
          end

          should "ask how many shifts per shift pattern" do
            add_response "8"
            assert_current_node :shift_worker_shifts_per_shift_pattern?
          end

          should "ask how many days per shift pattern" do
            add_response "8"
            add_response "4"
            assert_current_node :shift_worker_days_per_shift_pattern?
          end

          should "be done when all entered" do
            add_response "7"
            add_response "4"
            add_response "8"

            SmartAnswer::Calculators::HolidayEntitlement
              .expects(:new)
              .with(
                start_date: Date.parse("#{Date.today.year}-02-16"),
                leaving_date: Date.parse("#{Date.today.year}-08-01"),
                leave_year_start_date: nil,
                hours_per_shift: 7,
                shifts_per_shift_pattern: 4,
                days_per_shift_pattern: 8,
              ).returns(@stubbed_calculator)
            @stubbed_calculator.expects(:formatted_shift_entitlement).returns("some shifts")

            assert_current_node :shift_worker_done

            assert_state_variable :hours_per_shift, "7"
            assert_state_variable :shifts_per_shift_pattern, 4
            assert_state_variable :days_per_shift_pattern, 8

            assert_state_variable :holiday_entitlement_shifts, "some shifts"
          end
        end # with a leave year start date
      end # with a date
    end # leaving this year
  end # shift worker
end
