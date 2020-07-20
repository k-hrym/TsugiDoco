class Route < ApplicationRecord
  belongs_to :user

  has_many :spots,dependent: :destroy
  has_many :likes,dependent: :destroy

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

end
