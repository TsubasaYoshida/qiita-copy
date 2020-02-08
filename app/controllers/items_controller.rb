class ItemsController < ApplicationController
  before_action :set_item
  skip_before_action :check_logged_in, only: :show

  def show
    @comment = Comment.new
    @like = Like.find_or_initialize_by(user_id: current_user.id, item_id: @item.id)
  end

  def destroy
    @item.draft.destroy
    redirect_to current_user_url
  end

  private

  def set_item
    @item = Item.get_item(params[:screen_name], params[:id])
  end
end
