class ItemsController < ApplicationController
  skip_before_action :check_logged_in, only: :show

  def show
    @item = Draft.find(params[:id]).item
    @comment = Comment.new
  end

  def destroy
    @item = current_user.drafts.find_by_hashid(params[:id]).item
    @item.draft.destroy
    redirect_to :root
  end
end
