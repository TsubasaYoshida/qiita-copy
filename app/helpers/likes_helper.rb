module LikesHelper
  def get_contribution(screen_name)
    User.find_by!(screen_name: screen_name).items.inject(0) do |sum, item|
      sum + Like.where(item_id: item.id).count
    end
  end

  def class_thumbs_up_pressed(item)
    'item__thumbs-up-pressed' if pressed_like?(item)
  end

  def pressed_like?(item)
    # 未ログイン状態でも呼ばれるため、lonely-operatorを使用する
    Like.exists?(user_id: current_user&.id, item_id: item.id)
  end

  def get_contribution_ranking
    # group(:user_id) ではなく group('items.user_id') でテーブル指定する
    ranking = Like.joins(:item).group('items.user_id').order('count_items_user_id desc').count('items.user_id').first(10)
    ranking.map {|key, value| [User.find(key).screen_name, value]}
  end

  def get_like_instance(item)
    # 未ログイン状態でも呼ばれるため、lonely-operatorを使用する
    Like.find_or_initialize_by(user_id: current_user&.id, item_id: item.id)
  end
end
