class PlaceImage < ApplicationRecord
  belongs_to :place
  belongs_to :user

  attachment :image
end
