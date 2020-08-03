class Tag < ApplicationRecord
  belongs_to :place_image

  has_one :place,through: :place_image
end
