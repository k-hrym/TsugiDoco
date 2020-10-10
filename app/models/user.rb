class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image

  has_many :place_images
  accepts_attachments_for :place_images, attachment: :image

  has_many :routes,dependent: :destroy
  has_many :spots,through: :routes

  has_many :likes

  has_many :relations
  has_many :followings,through: :relations,source: :follow
  has_many :reverse_of_relations, class_name: 'Relation',foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relations,source: :user

  has_many :wents
  has_many :places,through: :wents
  has_many :wishes
  has_many :places,through: :wishes

  validates :name, presence: true,length: {maximum: 15}
  validates :profile,length: {maximum: 400}
  validates :is_valid, inclusion: { in: [true, false]}
  validates :sex,inclusion: {in: [nil,0,1,2]}

  scope :all_day, -> {where(created_at: Time.zone.now.all_day)}
  scope :all_week, -> {where(created_at: Time.zone.now.all_week)}
  scope :all_month, -> {where(created_at: Time.zone.now.all_month)}

  #validate :email_exist

  # def email_exist
  #   if User.where.not(id:id).where(email: email).where(is_valid:true).present?
  #     errors.add(:email,"email is already exist")
  #   end
  # end

  # プレイスにいきたい登録しているかをtrue/falseで返す
  def wishing?(place)
    self.wishes.find_by(place_id: place.id).present?
  end

  # プレイスにいった登録しているかをtrue/falseで返す
  def went?(place)
    self.wents.find_by(place_id: place.id).present?
  end

  # viewでis_validカラムに応じた文字列を定義する
  def valid_user
    case self.is_valid
    when true
      return '有効'
    when false
      return '退会済'
    end
  end

  # 性別の日本語表示
  def sex_display
    case self.sex
    when 1
      return '男性'
    when 2
      return '女性'
    when 3
      return 'その他'
    end
  end

  # 論理削除
  def active_for_authentication?
    super && (self.is_valid == true)
  end

  # ユーザーをフォローする
  def follow(other_user)
    unless self == other_user
      self.relations.find_or_create_by(follow_id: other_user.id)
    end
  end

  # ユーザーのフォローを外す
  def unfollow(other_user)
    relation = self.relations.find_by(follow_id: other_user.id)
    relation.destroy if relation
  end

  # ユーザーをフォローしているかをtrue/falseで返す
  def following?(other_user)
    self.followings.include?(other_user)
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "Guest-user"
    end
  end

end
