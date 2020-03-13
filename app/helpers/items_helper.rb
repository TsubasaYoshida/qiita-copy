module ItemsHelper
  def get_item_time(item)
    item.created_at < item.updated_at ? "#{l item.updated_at, format: :item}に更新" : "#{l item.created_at, format: :item}に投稿"
  end

  def item_url(item)
    Rails.application.routes.url_helpers.url_for(controller: :items, action: :show, id: item.draft.hashid, only_path: true)
  end
end
