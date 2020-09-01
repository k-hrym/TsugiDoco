class Place < ApplicationRecord
  belongs_to :genre

  has_many :place_images, dependent: :destroy, autosave: true
  has_many :users,through: :place_images
  accepts_attachments_for :place_images, attachment: :image

  has_many :spots
  has_many :routes,through: :spots

  has_many :wents
  has_many :users,through: :wents
  has_many :wishes
  has_many :users,through: :wishes

  has_many :tags,through: :place_images

  validates :name,presence: true,length: {maximum: 50}
  validates :explanation,length: {maximum: 300}
  validates :genre_id,presence: true, format: { with: /\A\d+\z/ }
  validates :postcode,length: {is: 7}, allow_blank: true
  validates :address,presence: true,length: {maximum: 100}
  validates :access,length: {maximum: 200}
  validates :tel,length: {in: 10..11}, allow_blank: true
  validates :hours,length: {maximum: 200}
  validates :price,length: {maximum: 200}
  validates :holiday,length: {maximum: 200}
  validates :is_closed, inclusion: {in: [true,false]}

  geocoded_by :address
  after_validation :geocode

  scope :all_day, -> {where(created_at: Time.zone.now.all_day)}
  scope :all_week, -> {where(created_at: Time.zone.now.all_week)}
  scope :all_month, -> {where(created_at: Time.zone.now.all_month)}

  def self.search(search)
    return nil if search.blank?
    Place.where(["name LIKE ? OR explanation LIKE ? OR address LIKE ?", "%#{search}%","%#{search}%","%#{search}%"])
  end

  # viewでis_closedカラムに応じた文字列を定義する
  def open_close
    case self.is_closed
    when true
      return ''
    when false
      return '閉店'
    end
  end

  # csvインポート用
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      # IDが見つかれば、レコードを呼び出し、見つかれなければ、新しく作成
      place = Place.new
      # CSVからデータを取得し、設定する
      place.attributes = row.to_hash.slice(*updatable_attributes)
      # 保存する
      place.save
    end
  end

  # 更新を許可するカラムを定義
  def self.updatable_attributes
    ["name","genre_id","explanation","postcode","address","access","tel","url","hours","price","holiday"]
  end

  # placeに紐づいたタグを多い順に並べて重複を削除。
  def with_tags
    self.tags.pluck(:name).group_by{|e| e}.sort_by{|_,v|-v.size}.map(&:first)
  end

  # 既存のPlaceに画像を追加するときだけ使うメソッド
  def add_place_images(params,user)
    params.each do |image|
      # Refileで複数アップロードするとパラメーター最初に[]が入ってしまうため、はじく
      unless image == "[]"
        self.place_images.new(image: image,user_id: user.id)
      end
    end
  end
end
