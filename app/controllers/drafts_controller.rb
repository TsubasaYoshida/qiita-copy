class DraftsController < ApplicationController
  before_action :set_draft, only: [:edit, :update, :destroy]

  def index
  end

  def new
    @draft = Draft.new
  end

  def edit
    @draft.restore_tag_names
    # バリデーションスキップする必要があるため、update_attribute を使用する
    @draft.update_attribute(:edit_after_posting, true) if @draft.item
  end

  def create
    @draft = Draft.new(draft_params)
    @draft.user_id = current_user.id

    if @draft.save
      @draft.attach_tags

      # TODO 本当は StringInquirer を使いたいが、うまく動かない
      if @draft.type == 'post'
        item = Item.make_copy(@draft)
        redirect_to item_url(item.user.screen_name, @draft.hashid), notice: '記事を投稿しました。'
      else
        redirect_to drafts_url, notice: '下書き保存しました。'
      end
    else
      render :new
    end
  end

  # パターン1: 未投稿下書き -> 未投稿下書き
  # パターン2: 未投稿下書き -> Qiitaに投稿
  # パターン3: 投稿後編集の下書き -> 投稿後編集の下書き
  # パターン4: 投稿後編集の下書き -> Qiita記事の更新
  def update
    if @draft.update(draft_params)
      @draft.attach_tags

      if @draft.type == 'post'
        message = @draft.item ? '記事を編集しました。' : '記事を投稿しました。'
        item = Item.make_copy(@draft)
        @draft.update(edit_after_posting: false)
        redirect_to item_url(item.user.screen_name, item.draft.hashid), notice: message
      else
        redirect_to drafts_url, notice: '下書きを更新しました。'
      end
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
    # 不正な親子関係の場合にエラーとなるように
    @draft = current_user.drafts.find_by_hashid(params[:id])
  end
end
