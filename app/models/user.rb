class User < ApplicationRecord
  has_secure_password

  # has_many :items, through: :likes は has_many :items と被っているので使えない
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
            on: %i(create password_reset)
  validate :old_password_authenticate,
           on: :password_reset

  def self.find_by_identity(identity)
    User.find_by(screen_name: identity) || User.find_by(email: identity)
  end

  private

  # 旧パスワードの認証
  def old_password_authenticate
    # TODO self.authenticate(old_password)だと認証OKにならないので一生バリデーション通らない(原因不明)
    # 仕方ないのでuserを持ってくる
    user = User.find(self.id)
    errors.add(:old_password, '現在のパスワードが間違っています。') unless user.authenticate(old_password)
  end
end
