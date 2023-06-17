class Hike < ApplicationRecord
  belongs_to :user
  has_many :reviews
  has_many :favorites
  has_many :users, through: :favorites
  has_many :points_of_interests
  has_many :locations, through: :points_of_interests
  has_many :hikes_categories
  has_many :categories, through: :hikes_categories
end
