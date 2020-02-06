class ItemsController < ApplicationController
  before_action :set_item
  skip_before_action :check_logged_in, only: :show

  def show
    @comment = Comment.new
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
