class Location < ApplicationRecord
  has_many :points_of_interests
  has_may :hikes, through: :points_of_interests
end
