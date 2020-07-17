class Place < ApplicationRecord
  belongs_to :genre

  has_many :place_images, dependent: :destroy, autosave: true
  accepts_attachments_for :place_images, attachment: :image

  has_many :spots

  def self.search(search)
    return Place.all unless search
    Place.where(["name LIKE ?", "%#{search}%"])
  end
end
