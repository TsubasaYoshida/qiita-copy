class ApplicationController < ActionController::Base
  include SessionsHelper

  before_action :check_logged_in
  before_action :set_path

  private

  def check_logged_in
    redirect_to login_url unless current_user
  end

  def set_path
    @path = "#{controller_path}##{action_name}"
  end
end
