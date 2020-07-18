class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image

  has_many :place_images
  accepts_attachments_for :place_images, attachment: :image

  has_many :routes,dependent: :destroy

  has_many :likes

  validates :name, presence: true
  #validate :email_exist
  validates :is_valid, inclusion: { in: [true, false]}
  validates :profile,length: {maximum: 500}

  # def email_exist
  #   if User.where.not(id:id).where(email: email).where(is_valid:true).present?
  #     errors.add(:email,"email is already exist")
  #   end
  # end

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
