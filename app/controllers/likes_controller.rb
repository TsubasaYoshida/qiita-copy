class LikesController < ApplicationController
  def create
    item = Draft.find(params[:draft_id]).item
    Like.create(user_id: current_user.id, item_id: item.id)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    like = current_user.likes.find(params[:id])
    like.destroy
    redirect_back(fallback_location: root_path)
  end
end
