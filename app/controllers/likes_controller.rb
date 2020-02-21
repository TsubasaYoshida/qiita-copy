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
    @item = Item.get_item(params[:screen_name], params[:draft_id])
  end
end
