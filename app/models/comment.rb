class Comment < ApplicationRecord
  include Hashid::Rails

  belongs_to :user
  belongs_to :item

  validates :body,
            presence: true,
            length: {maximum: 50_000}
end
