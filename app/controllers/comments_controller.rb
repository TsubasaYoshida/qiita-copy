class CommentsController < ApplicationController
  before_action :set_item, only: %i(create update destroy)
  before_action :set_comment, only: %i(edit update destroy)

  def edit
  end

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.item = @item
    if @comment.save
      redirect_to item_url(@item), notice: 'コメントを投稿しました。'
    else
      render 'items/show'
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to item_url(@item), notice: 'コメントを更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to item_url(@item), notice: 'コメントを削除しました。'
  end

  private

  def set_item
    @item = Draft.find(params[:draft_id]).item
  end

  def set_comment
    @comment = Draft.find(params[:draft_id]).item.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
