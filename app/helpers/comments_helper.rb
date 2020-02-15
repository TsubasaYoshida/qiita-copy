module CommentsHelper
  def my_comment?(comment)
    # 未ログイン状態でも呼ばれるため、lonely-operatorを使用する
    Comment.exists?(id: comment.id, user_id: current_user&.id)
  end
end
