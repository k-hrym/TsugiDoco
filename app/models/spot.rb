class Spot < ApplicationRecord
  belongs_to :route
  belongs_to :place, optional: true

  scope :place_nil, -> {where(place_id: nil)}

  def self.order_update(spots)
    n = 1
    spots.each do |spot|
      spot.update(order: n)
      n += 1
    end
  end
end
