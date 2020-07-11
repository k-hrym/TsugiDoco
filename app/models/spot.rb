class Spot < ApplicationRecord
  belongs_to :route
  belongs_to :place
end
