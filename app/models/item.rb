class Item < ApplicationRecord
  include Hashid::Rails

  belongs_to :user
  belongs_to :draft
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :users, through: :likes
  has_and_belongs_to_many :tags

  scope :recent, -> {order(created_at: :desc)}

  def self.get_item(screen_name, draft_id)
    User.find_by!(screen_name: screen_name).drafts.find_by_hashid(draft_id).item
  end

  def url
    Rails.application.routes.url_helpers.url_for(controller: :items, action: :show, screen_name: self.user.screen_name, id: self.draft.hashid, only_path: true)
  end
end
