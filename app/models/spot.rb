class Spot < ApplicationRecord
  belongs_to :route
  belongs_to :place, optional: true

  validates :place_id,presence: true,on: [:update]
  validates :route_id,:order,presence: true
  validates :memo,length: {maximum: 200}

  scope :place_nil, -> {where(place_id: nil)}

  # 公開時に順番を更新するため
  def self.order_update(spots)
    n = 1
    spots.each do |spot|
      spot.update!(order: n)
      n += 1
    end
  end
end
