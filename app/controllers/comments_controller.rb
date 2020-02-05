class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]
  skip_before_action :check_logged_in

  def edit
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @item = User.find_by!(screen_name: params[:screen_name]).drafts.find_by_hashid(params[:item_id]).item
    @comment.item_id = @item.id

    if @comment.save
      redirect_to @comment.item, notice: 'コメントを投稿しました。'
    else
      render 'items/show'
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to @comment, notice: 'Comment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to comments_url, notice: 'Comment was successfully destroyed.'
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
