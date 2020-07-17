class Genre < ApplicationRecord
  has_many :places

  validates :name,presence: true

  scope :only_valid, -> { where(is_valid: true) }

  def valid_invalid
    case self.is_valid
    when true
      return '有効'
    when false
      return '無効'
    end
  end
end
