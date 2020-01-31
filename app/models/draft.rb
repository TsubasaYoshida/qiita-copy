class Draft < ApplicationRecord
  include Hashid::Rails
  extend Enumerize

  belongs_to :user
  has_one :item

  enumerize :status, in: %w(post limited_post save), default: :post

  validates :title,
            presence: true,
            length: {maximum: 255}
  validates :body,
            presence: true,
            length: {maximum: 100_000}
  validates :status,
            inclusion: {in: %w(post limited_post save)}

end
