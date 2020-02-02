class ApplicationController < ActionController::Base
  include SessionsHelper
  include ItemsHelper

  before_action :check_logged_in

  private

  def check_logged_in
    unless current_user
      redirect_to login_url
    end
  end
end
