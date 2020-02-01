class User < ApplicationRecord
  has_secure_password

  has_many :items
  has_many :drafts

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
