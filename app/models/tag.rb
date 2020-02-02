class Tag < ApplicationRecord

  has_and_belongs_to_many :drafts
  has_and_belongs_to_many :items

  validates :name,
            presence: true,
            length: {maximum: 50}
end
