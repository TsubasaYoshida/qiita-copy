class ItemsController < ApplicationController
  before_action :set_item, only: :show
  before_action :set_comment, only: :show
  skip_before_action :check_logged_in, only: :show

  def show
  end

  def destroy
    @item = Item.get_item(current_user.screen_name, params[:id])
    @item.draft.destroy
    redirect_to :root
  end

  private

  def set_item
    @item = Item.get_item(params[:screen_name], params[:id])
  end

  def set_comment
    @comment = Comment.new
  end
end
