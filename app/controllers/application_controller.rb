class ApplicationController < ActionController::Base
  include SessionsHelper

  http_basic_authenticate_with name: ENV['BASIC_AUTH_USERNAME'], password: ENV['BASIC_AUTH_PASSWORD'] if Rails.env.production?

  before_action :check_logged_in
  before_action :set_path

  private

  def check_logged_in
    redirect_to new_session_url unless current_user
  end

  def set_path
    @path = "#{controller_path}##{action_name}"
  end
end
