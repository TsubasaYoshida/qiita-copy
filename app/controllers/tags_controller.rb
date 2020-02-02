class TagsController < ApplicationController
  skip_before_action :check_logged_in

  def show
    @tag = Tag.find_by!(name: params[:name])
  end
end
