module ItemsHelper
  def get_item_time(item)
    item.created_at < item.updated_at ? "#{l item.created_at, format: :item}に更新" : "#{l item.created_at, format: :item}に投稿"
  end

  def my_item?(item)
    # 未ログイン状態でも呼ばれるため、lonely-operatorを使用する
    Item.exists?(id: item.id, user_id: current_user&.id)
  end
end
