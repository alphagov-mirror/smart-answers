namespace :maintenance do
  desc "Create full combination flow tests for the Coronavirus Find Support smart answer."
  task create_find_support_flow_tests: [:environment] do
    abort "This task will only run in `development`" unless Rails.env.development?
    abort "Please supply an output_file" if ENV["output_file"].blank?

    filter_options = %i[
      feeling_unsafe
      paying_bills
      getting_food
      being_unemployed
      going_to_work
      somewhere_to_live
      mental_health
    ]

    test_counter = 0
    file = File.open(ENV["output_file"], "w")

    file.puts "context 'all combinations of all options' do"
    (0..filter_options.length).each do |filter_option_count|
      filter_options.combination(filter_option_count).to_a.each do |combination|
        if filter_option_count.zero?
          file.puts "  should 'show results when no options are selected' do"
        else
          file.puts "\n  should 'show results when #{combination.to_sentence} are selected' do"
        end

        file.puts "    assert_current_node :need_help_with?"
        file.puts "    add_response '#{combination.join(',')}'"

        if combination.include?(:feeling_unsafe)
          file.puts "    assert_current_node :feel_safe?"
          file.puts "    add_response 'no'"
        end

        if combination.include?(:paying_bills)
          file.puts "    assert_current_node :afford_rent_mortgage_bills?"
          file.puts "    add_response 'no'"
        end

        if combination.include?(:getting_food)
          file.puts "    assert_current_node :afford_food?"
          file.puts "    add_response 'no'"
          file.puts "    assert_current_node :get_food?"
          file.puts "    add_response 'yes'"
        end

        if combination.include?(:being_unemployed)
          file.puts "    assert_current_node :self_employed?"
          file.puts "    add_response 'no'"
          file.puts "    assert_current_node :have_you_been_made_unemployed?"
          file.puts "    add_response 'no'"
          file.puts "    assert_current_node :are_you_off_work_ill?"
          file.puts "    add_response 'no'"
        end

        if combination.include?(:going_to_work)
          file.puts "    assert_current_node :worried_about_work?"
          file.puts "    add_response 'no'"
        end

        if combination.include?(:somewhere_to_live)
          file.puts "    assert_current_node :have_somewhere_to_live?"
          file.puts "    add_response 'yes'"
          file.puts "    assert_current_node :have_you_been_evicted?"
          file.puts "    add_response 'no'"
        end

        if combination.include?(:mental_health)
          file.puts "    assert_current_node :mental_health_worries?"
          file.puts "    add_response 'no'"
        end

        file.puts "    assert_current_node :nation?"
        file.puts "    add_response 'england,scotland,wales,northern_ireland'"
        file.puts "    assert_current_node :results"
        file.puts "  end\n"

        test_counter += 1
      end
    end
    file.puts "end\n"

    file.close
    puts "[#{test_counter}] tests created in #{ENV['output_file']}"
  end
end
