class User < ApplicationRecord
  has_secure_password

  # has_many :items, through: :likes は has_many :items, dependent: :destroy と被っているので使えない
  has_many :items, dependent: :destroy
  has_many :drafts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  attr_accessor :old_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :screen_name,
            presence: true,
            length: {maximum: 20},
            # MySQLの場合、大文字小文字を区別するかについて明示する必要がある(Rails6.1から)。
            uniqueness: {case_sensitive: false}
  validates :email,
            presence: true,
            length: {maximum: 255},
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}
  validates :password,
            presence: true,
            length: {minimum: 6},
            # サインアップ時と、パスワードリセット時のみバリデーションする
            on: [:create, :password_reset]
  validates :old_password,
            presence: true,
            length: {minimum: 6},
            on: :password_reset
end
