module ItemsHelper
  def item_url(item)
    "/#{item.user.screen_name}/items/#{item.draft.hashid}"
  end
end
