class Route < ApplicationRecord
  belongs_to :user

  has_many :spots,dependent: :destroy

  scope :released, -> { where(status: true) }

  def display_an_image
    self.spots.first.place.place_images.first
    #ルートに紐づくspotの一つ目のplaceの画像の一つ目を持ってくる
  end

  def status_display
    case self.status
    when true
      return "公開"
    when false
      return "下書き"
    end
  end
end
