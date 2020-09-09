require "test_helper"

class CurrentQuestionHelperTest < ActionView::TestCase
  context "#current_question_path" do
    should "return link to smart answer" do
      assert_equal smart_answer_path(flow_name), current_question_path(presenter)
    end

    should "return link to session answer when flow uses sessions" do
      assert_equal update_session_flow_path(flow_name, node_name), current_question_path(session_presenter)
    end
  end

  context "#restart_flow_path" do
    should "return root smart answer path" do
      assert_equal smart_answer_path(flow_name), restart_flow_path(presenter)
    end

    should "return root smart answer path for session answer" do
      @params = { id: "coronavirus_find_support" }
      assert_equal smart_answer_path(flow_name), restart_flow_path(session_presenter)
    end
  end

  context "#start_of_flow_path" do
    should "return path to first page in smart flow" do
      assert_equal smart_answer_path(flow_name, started: "y"), start_of_flow_path(presenter)
    end

    should "return path to first page in session flow when session answer" do
      assert_equal session_flow_path(flow_name, node_name: first_question.name), start_of_flow_path(session_presenter)
    end
  end

  def flow_name
    "coronavirus-find-support"
  end

  def node_name
    "need_help_with"
  end

  def params
    @params ||= ActionController::Parameters.new(
      id: flow_name,
    )
  end

  def presenter
    @presenter ||= OpenStruct.new(
      accepted_responses: [],
      name: flow_name,
    )
  end

  def session_presenter
    @session_presenter ||= OpenStruct.new(
      "use_session?" => true,
      current_state: current_state,
      questions: [first_question],
      name: flow_name,
    )
  end

  def current_state
    @current_state ||= OpenStruct.new(
      current_node: node_name,
    )
  end

  def first_question
    @first_question ||= OpenStruct.new(
      name: "first",
    )
  end
end
