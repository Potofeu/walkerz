class Favorite < ApplicationRecord
  belongs_to :hike
  belongs_to :user
end
