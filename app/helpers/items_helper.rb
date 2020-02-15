module ItemsHelper
  def item_url(item)
    "/#{item.user.screen_name}/items/#{item.draft.hashid}"
  end

  def get_item_time(item)
    item.created_at < item.updated_at ? "#{l item.created_at, format: :item}に更新" : "#{l item.created_at, format: :item}に投稿"
  end

  def my_item?(item)
    Item.exists?(id: item.id, user_id: current_user.id)
  end
end
