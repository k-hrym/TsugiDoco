class Route < ApplicationRecord
  belongs_to :user

  has_many :spots,dependent: :destroy

  scope :released, -> { where(status: true) }

  def display_an_image
    self.spots.first.place.place_images.first
    #ルートに紐づくspotの一つ目のplaceの画像の一つ目を持ってくる
  end
end
