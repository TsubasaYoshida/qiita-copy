module CommentsHelper
  def my_comment?(comment)
    Comment.exists?(id: comment.id, user_id: current_user.id)
  end
end
