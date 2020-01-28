class Item < ApplicationRecord
  extend Enumerize

  belongs_to :user

  enumerize :status, in: %w(post limited_post save), default: :post, scope: true

  validates :title,
            presence: true,
            length: {maximum: 255}

  validates :body,
            presence: true,
            length: {maximum: 100_000}

  validates :status,
            inclusion: {in: %w(post limited_post save)}

end
