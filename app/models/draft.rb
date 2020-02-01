class Draft < ApplicationRecord
  include Hashid::Rails
  extend Enumerize

  belongs_to :user
  has_one :item

  attr_accessor :type

  BEFORE_POST = %w(post limited_post save)
  AFTER_POST = %w(post save)
  AFTER_LIMITED_POST = %w(limited_post save)

  validates :title,
            presence: true,
            length: {maximum: 255}
  validates :body,
            presence: true,
            length: {maximum: 100_000}
  validates :type,
            inclusion: {in: %w(post limited_post save)}

end
