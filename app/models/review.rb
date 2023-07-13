class Review < ApplicationRecord
  belongs_to :user
  belongs_to :hike

  validates :rating, presence: true
end
