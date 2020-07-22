class Route < ApplicationRecord
  belongs_to :user

  has_many :spots,dependent: :destroy
  has_many :places,through: :spots
  has_many :likes,dependent: :destroy
  has_many :users,through: :likes

  validates :title,presence: true,length: {maximum: 50}
  validates :explanation,length: {maximum: 500}
  validates :status,presence: true,incusion: {in: [true,false]}

  scope :released, -> { where(status: true) }

  #ルートに紐づくspotの一つ目のplaceの画像の一つ目を持ってくる
  def display_an_image
    self.spots.first.place.place_images.first
  end

  # viewでstatusカラムに応じた文字列を定義する
  def status_display
    case self.status
    when true
      return "公開"
    when false
      return "下書き"
    end
  end

  def released? #公開済みならtrue
    self.status == true
  end

  #ルートの検索
  def self.search(search)
    return nil if search.blank?
    #入力された文字でヒットするルート
    routes = Route.where(["title LIKE ? OR explanation LIKE ?", "%#{search}%","%#{search}%"])
    #入力された文字でヒットしたplaceを含むルート
    places = Place.search(search)
    place_to_routes = places.map do |place|
      spots = Spot.where(place_id: place.id)
      spots.map{|spot| spot.route}
    end
    # 上の二つを足した上で、配列の多重配列を解除、かつ公開済みのもの、重複を削除
    return (routes + place_to_routes).flatten.map{|route| route if route.status == true}.uniq
  end


end
