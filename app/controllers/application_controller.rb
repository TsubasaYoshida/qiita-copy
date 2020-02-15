class ApplicationController < ActionController::Base
  include SessionsHelper
  include ItemsHelper

  before_action :check_logged_in
  before_action :get_path

  private

  def check_logged_in
    unless current_user
      redirect_to login_url
    end
  end

  def get_path
    @path = "#{controller_path}##{action_name}"
  end
end
