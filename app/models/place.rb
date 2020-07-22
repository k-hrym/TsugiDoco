class Place < ApplicationRecord
  belongs_to :genre

  has_many :place_images, dependent: :destroy, autosave: true
  accepts_attachments_for :place_images, attachment: :image

  has_many :spots

  has_many :wents
  has_many :wishes

  validates :name,presence: true
  validates :genre_id,presence: true
  validates :address,presence: true

  geocoded_by :address
  after_validation :geocode

  def self.search(search)
    return Place.all unless search
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
end
