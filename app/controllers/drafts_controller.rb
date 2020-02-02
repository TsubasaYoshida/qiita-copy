class DraftsController < ApplicationController
  before_action :set_draft, only: [:show, :edit, :update, :destroy]
  before_action :select_drafts, only: [:index, :show]

  # 本家と挙動揃えられていない
  def index
  end

  def show
  end

  def new
    @draft = Draft.new
  end

  def edit
    @draft.restore_tag_names
    @draft.update(edit_after_posting: true) if @draft.item
  end

  def create
    @draft = Draft.new(draft_params)
    @draft.user_id = current_user.id

    if @draft.save
      @draft.attach_tags

      if @draft.type == 'post'
        Item.make_copy(@draft)
        redirect_to item_url(@draft.item), notice: '記事を投稿しました。'

      elsif @draft.type == 'save'
        redirect_to @draft, notice: '下書き保存しました。'

      else
        # 限定共有投稿
        # TODO implement
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
    draft = draft_params

    if draft[:type] == 'save'
      # パターン1: 未投稿下書き -> 未投稿下書き
      # パターン3: 投稿後編集の下書き -> 投稿後編集の下書き
      if @draft.update(draft)
        redirect_to @draft, notice: '下書きを更新しました。'
      else
        render :edit
      end

    elsif draft[:type] == 'post'

      if @draft.item # パターン4: 投稿後編集の下書き -> Qiita記事の更新
        @draft.edit_after_posting = false
        if @draft.update(draft) && @draft.item.update(title: draft[:title], body: draft[:body])
          redirect_to "/#{current_user.screen_name}/items/#{@draft.hashid}", notice: '記事を投稿しました。'
        else
          render :edit
        end

      else # パターン2: 未投稿下書き -> Qiitaに投稿
        item = Item.new(
            title: draft[:title],
            body: draft[:body],
            user_id: current_user.id,
            draft_id: @draft.id,
        )
        if @draft.update(draft) && item.save
          redirect_to "/#{current_user.screen_name}/items/#{@draft.hashid}", notice: '記事を投稿しました。'
        else
          render :edit
        end
      end

    else
      # 限定共有投稿
      # TODO implement
      # TODO item と private は共存しないので、そのロジックバリデーションが必要
    end
  end

  # Vue.jsに任せるべき?(Railsのみだと本家と挙動揃えられない)
  def destroy
    if @draft.item
      @draft.update(title: @draft.item.title, body: @draft.item.body)
    else
      @draft.destroy
    end

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

  def select_drafts
    # 未投稿のものと、投稿後に編集したもの
    @drafts = current_user.drafts.select do |draft|
      !draft.item || draft.edit_after_posting
    end
  end
end
