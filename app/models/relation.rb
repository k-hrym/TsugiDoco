class Relation < ApplicationRecord
  belongs_to :user
  belongs_to :follow,class_name: 'User'

  validates :user_id,:follow_id,presence: true
end
