class PointsOfInterest < ApplicationRecord
  belongs_to :hike
  belongs_to :location
end
