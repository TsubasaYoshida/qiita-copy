class Item < ApplicationRecord
  include Hashid::Rails

  belongs_to :user
  belongs_to :draft
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :users, through: :likes
  has_and_belongs_to_many :tags

  scope :recent, -> {order(created_at: :desc)}
end
