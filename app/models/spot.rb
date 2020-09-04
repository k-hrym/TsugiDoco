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

  def self.find_next_spots(spots)
    # @placeに紐づくSpotが登録されているかを確認
    unless spots.nil?
      #あればその次にいったSpotを配列にして返す
      @next = spots.map do |spot|
        route_spots = spot.route.spots
        route_spots.find_by(order: spot.order + 1)
      end
      return @next.compact #nilは含めない
    end
  end
end
