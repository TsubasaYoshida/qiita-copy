class TagsController < ApplicationController
  skip_before_action :check_logged_in

  def show
    # item が1つも紐づいていないなら、404にする
    @tag = Tag.find_by!(name: params[:name])
    raise ActiveRecord::RecordNotFound if @tag.items.size.zero?
  end
end
