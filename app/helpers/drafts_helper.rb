module DraftsHelper
  def get_drafts
    # 未投稿のものと、投稿後に編集したもの
    drafts = current_user.drafts.select do |draft|
      !draft.item || draft.edit_after_posting
    end
    drafts.sort_by! {|draft| draft[:updated_at]}.reverse!
  end
end
