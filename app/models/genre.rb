class Genre < ApplicationRecord
  has_many :places

  validates :name,presence: true,length: {maximum: 10}

  scope :only_valid, -> { where(is_valid: true) }

  scope :all_day, -> {where(created_at: Time.zone.now.all_day)}
  scope :all_week, -> {where(created_at: Time.zone.now.all_week)}
  scope :all_month, -> {where(created_at: Time.zone.now.all_month)}

  # viewでis_validカラムに応じた文字列を定義する
  def valid_invalid
    case self.is_valid
    when true
      return '有効'
    when false
      return '無効'
    end
  end
end
