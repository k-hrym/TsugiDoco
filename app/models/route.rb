class Route < ApplicationRecord
  belongs_to :user

  has_many :spots,dependent: :destroy
end
