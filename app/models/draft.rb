class Draft < ApplicationRecord
  include Hashid::Rails

  belongs_to :user
end
