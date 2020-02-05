class Item < ApplicationRecord
  belongs_to :user
  belongs_to :draft
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :tags

  def self.make_copy(draft)
    # レコードがあれば更新、無ければ作成
    item = self.find_or_initialize_by(draft_id: draft.id)
    item.update(
        title: draft.title,
        body: draft.body,
        user_id: draft.user_id,
        draft_id: draft.id,
    )

    # 毎回タグをデタッチしてからアタッチし直す(タグ削除やタグ更新のため)
    item.tags.clear
    # draft.tags.each だと動かない。draft.tags.all.each なら動く。
    draft.tags.all.each do |tag|
      tag.items << item
    end

    item
  end
end
