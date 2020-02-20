class Item < ApplicationRecord
  include Hashid::Rails

  belongs_to :user
  belongs_to :draft
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :users, through: :likes
  has_and_belongs_to_many :tags

  def self.get_item(screen_name, draft_id)
    # 不正な親子関係の場合にエラーとなるように
    User.find_by!(screen_name: screen_name).drafts.find_by_hashid(draft_id).item
  end

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

  def url
    Rails.application.routes.url_helpers.url_for(controller: :items, action: :show, screen_name: self.user.screen_name, id: self.draft.hashid, only_path: true)
  end
end
