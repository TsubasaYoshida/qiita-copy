class Draft < ApplicationRecord
  include Hashid::Rails
  extend Enumerize

  belongs_to :user
  has_one :item

  attr_accessor :tags
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
  validates :tags,
            presence: true,
            # 最大50文字のタグが5つまで＝250文字、スペースで区切るためそのスペース分＝4文字
            length: {maximum: 254}

end
