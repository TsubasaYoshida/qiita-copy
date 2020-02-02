class Item < ApplicationRecord
  belongs_to :user
  belongs_to :draft
  has_and_belongs_to_many :tags

  def self.make_copy(draft)
    item = self.create(
        title: draft.title,
        body: draft.body,
        user_id: draft.user_id,
        draft_id: draft.id,
    )

    # raft.tags.each だと動かない
    draft.tags.all.each do |tag|
      tag.items << item
    end
  end
end
