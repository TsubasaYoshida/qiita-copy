class ItemsController < ApplicationController
  skip_before_action :check_logged_in

  def show
    # 不正な親子関係の場合にエラーとなるように
    @item = User.find_by!(screen_name: params[:screen_name]).items.find_by_hashid(params[:id])
  end
end
