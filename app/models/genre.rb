class Genre < ApplicationRecord
  has_many :places

  validates :name,presence: true

  scope :only_valid, -> { where(is_valid: true) }
end
