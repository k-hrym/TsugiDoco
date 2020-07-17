class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image

  has_many :place_images
  accepts_attachments_for :place_images, attachment: :image

  has_many :routes,dependent: :destroy

  validates :name,:email, presence: true
  validates :is_valid, inclusion: { in: [true, false]}
  validates :profile,length: {maximum: 500}

  def valid_user
    case self.is_valid
    when true
      return '有効'
    when false
      return '退会済'
    end
  end

  def active_for_authentication?
    super && (self.is_valid == true)
  end

end
