class TagsController < ApplicationController
  skip_before_action :check_logged_in

  def show
    @tag = Tag.find(params[:id])
  end
end
