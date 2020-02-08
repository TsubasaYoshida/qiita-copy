class Like < ApplicationRecord
  belongs_to :user
  belongs_to :item

  validates_uniqueness_of :user_id, scope: :item_id
  validate :my_item_valid?

  def my_item?
    Item.exists?(id: item_id, user_id: user_id)
  end

  private

  # 自分の記事にいいねすることはできない
  def my_item_valid?
    # TODO もっといい書き方ありそう
    errors.add(:base, '') if my_item?
  end

end
