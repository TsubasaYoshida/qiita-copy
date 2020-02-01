class Draft < ApplicationRecord
  include Hashid::Rails
  extend Enumerize

  belongs_to :user
  has_one :item

  attr_accessor :before_post

  enumerize :before_post, in: %w(post limited_post save)
  enumerize :after_post, in: %w(post save)
  enumerize :after_limited_post, in: %w(limited_post save)

  validates :title,
            presence: true,
            length: {maximum: 255}
  validates :body,
            presence: true,
            length: {maximum: 100_000}
  validates :before_post,
            inclusion: {in: %w(post limited_post save)}
  validates :after_post,
            inclusion: {in: %w(post save)}
  validates :after_limited_post,
            inclusion: {in: %w(limited_post save)}

end
