class User < ApplicationRecord
  has_secure_password

  # has_many :items, through: :likes は has_many :items, dependent: :destroy と被っているので使えない
  has_many :items, dependent: :destroy
  has_many :drafts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :screen_name,
            presence: true,
            length: {maximum: 20},
            uniqueness: true
  validates :email,
            presence: true,
            length: {maximum: 255},
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: true
  validates :password,
            presence: true,
            length: {minimum: 6}
end
