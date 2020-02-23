class ItemsController < ApplicationController
  before_action :set_item
  before_action :set_comment, only: :show
  skip_before_action :check_logged_in, only: :show

  def show
  end

  def destroy
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
