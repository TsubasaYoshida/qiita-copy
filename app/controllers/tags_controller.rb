class TagsController < ApplicationController
  skip_before_action :check_logged_in

  def show
    # TODO item が1つも紐づいていないなら、404にしたい
    @tag = Tag.find_by!(name: params[:name])
  end
end
