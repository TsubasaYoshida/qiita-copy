class ItemsController < ApplicationController
  skip_before_action :check_logged_in

  def show
    # 不正な親子関係の場合にエラーとなるように
    user = User.find_by!(screen_name: params[:screen_name])
    @item = user.drafts.find_by_hashid(params[:id]).item
  end
end
