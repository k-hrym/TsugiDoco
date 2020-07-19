class Wish < ApplicationRecord
  belongs_to :user
  belongs_to :place

  def wishing?(place)
    self.wishes.find_by(place_id: place.id).present?
  end
end
