class Item < ApplicationRecord
  include Hashid::Rails

  belongs_to :user
  belongs_to :draft
end
