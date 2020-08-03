class PlaceImage < ApplicationRecord
  belongs_to :place
  belongs_to :user

  has_many :tags

  # validates :image_id,presence: true

  attachment :image

  def self.add_place_images(params,place,user) #既存のPlaceに追加するときだけ使う
    params.each do |image|
      unless image == "[]" #Refileで複数アップロードするとパラメーター最初に[]が入ってしまうため、はじく
        new_image = place.place_images.new(image: image)
        new_image.user = user
        new_image.save

        # VisionAPIを用いてplace_imageにタグを付与
        new_image.create_tag
      end
    end
  end

  # VisionAPIを用いてタグを生成するようのメソッド
  def create_tag
    tags = Vision.get_image_data(self)
    tags.each do |tag|
      self.tags.create(name: tag)
    end
  end

end

