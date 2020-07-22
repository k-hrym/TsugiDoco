class Spot < ApplicationRecord
  belongs_to :route
  belongs_to :place, optional: true

  validates :route_id,:order,presence: true
  validates :memo,length: {maximum: 200}

  scope :place_nil, -> {where(place_id: nil)}

  # SPOTが削除、追加された時に順番を更新するため
  def self.order_update(spots)
    n = 1
    spots.each do |spot|
      spot.update(order: n)
      n += 1
    end
  end
end
