class Place < ApplicationRecord
  belongs_to :genre

  has_many :place_images, dependent: :destroy, autosave: true
  accepts_attachments_for :place_images, attachment: :image
end
