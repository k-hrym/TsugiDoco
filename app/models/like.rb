class Like < ApplicationRecord
  belongs_to :user
  belongs_to :route

  scope :liked,->(route,user) {where(route_id: route.id,user_id: user.id)}
end
