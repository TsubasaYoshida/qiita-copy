class CommentsController < ApplicationController
  before_action :set_item, only: %i(create update destroy)
  before_action :set_comment, only: %i(edit update destroy)

  def edit
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.assign_attributes(user_id: current_user.id, item_id: @item.id)
    if @comment.save
      redirect_to @item.url, notice: 'コメントを投稿しました。'
    else
      render 'items/show'
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to @item.url, notice: 'コメントを更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to @item.url, notice: 'コメントを削除しました。'
  end

  private

  def set_item
    @item = Item.get_item(params[:screen_name], params[:item_id])
  end

  def set_comment
    @comment = Item.get_item(params[:screen_name], params[:item_id]).comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
