class Form
  include ActiveModel::Model
  include ActiveModel::Validations

  NotImplementedError = Class.new(StandardError)

  attr_accessor :session
  attr_reader :params, :question_name, :flow_name

  def initialize(params, session, flow_name, question_name)
    @params = params
    @session = session
    @flow_name = flow_name
    @question_name = question_name
  end

  def checkbox_options
    options.each_with_object([]) do |(key, value), array|
      array << { label: value, value: key.to_s }
    end
  end

  def radio_options
    options.each_with_object([]) do |(key, value), array|
      array << { text: value, value: key.to_s }
    end
  end

  def options
    raise NotImplementedError, "The options method has not been defined"
  end

  def save
    session[:flow_name] ||= {}
    session[:flow_name][:question_name] = params[:question_name]
  end
end
