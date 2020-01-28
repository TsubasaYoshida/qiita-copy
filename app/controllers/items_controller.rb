class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :update, :destroy]
  skip_before_action :check_logged_in, only: :show

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def edit
  end

  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id
    if @item.save
      redirect_to @item, notice: '記事を投稿しました。'
    else
      render :new
    end
  end

  def update
    if @item.update(item_params)
      redirect_to @item, notice: '記事を更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to current_user, notice: '記事を削除しました。'
  end

  private

  def set_item
    # 不正な親子関係の場合にエラーとなるように
    @item = current_user.items.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:user_id, :title, :body, :status)
  end
end
