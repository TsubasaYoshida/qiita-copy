module DraftsHelper
  def get_drafts
    # 未投稿のものと、投稿後に編集したもの
    current_user.drafts.select do |draft|
      !draft.item || draft.edit_after_posting
    end
  end
end
