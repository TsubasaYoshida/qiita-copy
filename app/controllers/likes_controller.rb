class LikesController < ApplicationController
  before_action :set_item, only: :create

  def create
    Like.create(user_id: current_user.id, item_id: @item.id)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    current_user.likes.find(params[:id]).destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def set_item
    @item = Draft.find(params[:draft_id]).item
  end
end
