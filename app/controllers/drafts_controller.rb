class DraftsController < ApplicationController
  before_action :set_draft, only: %i(edit update destroy)

  def index
  end

  def new
    @draft = Draft.new
  end

  def edit
    # 投稿後に編集した記事を下書き一覧に表示するために、touchする
    @draft.touch
  end

  def create
    @draft = current_user.drafts.build(draft_params)
    if @draft.save
      # TODO 本当は StringInquirer を使いたいが、うまく動かない
      redirect_to @draft.item.url, notice: '記事を投稿しました。' if @draft.type == 'post'
      redirect_to drafts_url, notice: '下書き保存しました。' if @draft.type == 'save'
    else
      render :new
    end
  end

  def update
    message = @draft.get_update_message
    if @draft.update_draft(draft_params)
      redirect_to @draft.item_url, notice: message if @draft.type == 'post'
      redirect_to drafts_url, notice: '下書きを更新しました。' if @draft.type == 'save'
    else
      render :edit
    end
  end

  def destroy
    @draft.destroy_draft
    redirect_to drafts_url
  end

  private

  def draft_params
    params.require(:draft).permit(:title, :body, :type, :tag_names)
  end

  def set_draft
    @draft = current_user.drafts.find_by_hashid(params[:id])
  end
end
