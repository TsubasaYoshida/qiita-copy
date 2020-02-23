class Like < ApplicationRecord
  belongs_to :user
  belongs_to :item

  validates_uniqueness_of :user_id, scope: :item_id
  validate :my_item_valid?

  private

  # 自分の記事にいいねすることはできない
  def my_item_valid?
    errors.add(:base, '') if Item.exists?(id: item_id, user_id: user_id)
  end
end
