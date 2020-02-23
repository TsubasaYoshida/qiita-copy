module ItemsHelper
  def get_item_time(item)
    item.created_at < item.updated_at ? "#{l item.updated_at, format: :item}に更新" : "#{l item.created_at, format: :item}に投稿"
  end
end
