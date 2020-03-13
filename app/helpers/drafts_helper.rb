module DraftsHelper
  def get_drafts
    # 未投稿のものと、投稿後に編集したもの
    drafts = current_user.drafts.select do |draft|
      !draft.item || draft.updated_at > draft.item.updated_at
    end
    drafts.sort_by! {|draft| draft[:updated_at]}.reverse!
  end

  def selected_draft_type(draft)
    draft.item ? :save : :post
  end
end
