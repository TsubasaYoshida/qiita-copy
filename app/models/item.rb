class Item < ApplicationRecord
  belongs_to :user
  belongs_to :draft

  attr_accessor :before_post
end
