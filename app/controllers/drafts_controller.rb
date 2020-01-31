class DraftsController < ApplicationController
  before_action :set_draft, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @draft = Draft.new
  end

  def edit
  end

  def create
    draft = draft_params
    draft.delete(:status)
    @draft = Draft.new(draft)
    @draft.user_id = current_user.id
    @item = Item.new(draft)
    @item.user_id = current_user.id

    if @draft.save
      @item.draft_id = @draft.id
      @item.save
      redirect_to "/#{current_user.screen_name}/items/#{@draft.hashid}", notice: '記事を投稿しました。'
    else
      render :new
    end
  end

  def update
    if @draft.update(draft_params)
      redirect_to @draft, notice: '記事を更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @draft.destroy
    redirect_to current_user, notice: '記事を削除しました。'
  end

  private

  def set_draft
    # 不正な親子関係の場合にエラーとなるように
    @draft = current_user.drafts.find_by_hashid(params[:id])
  end

  def draft_params
    params.require(:draft).permit(:title, :body, :status)
  end
end
