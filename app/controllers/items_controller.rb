class ItemsController < ApplicationController
  before_action :set_item
  skip_before_action :check_logged_in, only: :show

  def show
  end

  def destroy
    @item.draft.destroy
    redirect_to current_user_url
  end

  private

  def set_item
    # 不正な親子関係の場合にエラーとなるように
    user = User.find_by!(screen_name: params[:screen_name])
    @item = user.drafts.find_by_hashid(params[:id]).item
  end
end
