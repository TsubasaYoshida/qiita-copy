module LikesHelper
  def get_contribution(screen_name)
    contribution_count = 0
    User.find_by!(screen_name: screen_name).items.each do |item|
      contribution_count += Like.where(item_id: item.id).count
    end
    contribution_count
  end

  def pressed_like?(item)
    Like.exists?(user_id: current_user.id, item_id: item.id)
  end

  # TODO もっとうまく書けるかもしれない...
  def get_contribution_ranking
    # group(:user_id) ではなく group('items.user_id') でテーブル指定する
    ranking = Like.joins(:item).group('items.user_id').order('count_items_user_id desc').count('items.user_id').first(10)
    ranking.map {|key, value| [User.find(key).screen_name, value]}
  end
end
