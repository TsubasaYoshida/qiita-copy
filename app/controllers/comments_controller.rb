class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]
  skip_before_action :check_logged_in

  def edit
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    # items/show に飛ばすため、@item も用意する
    @item = Item.get_item(params[:screen_name], params[:item_id])
    @comment.item_id = @item.id

    if @comment.save
      redirect_to @comment.item, notice: 'コメントを投稿しました。'
    else
      render 'items/show'
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to @comment.item, notice: 'コメントを更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    # destroy しても @comment.item でいける
    redirect_to @comment.item, notice: 'コメントを削除しました。'
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
