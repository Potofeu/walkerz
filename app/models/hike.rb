class Hike < ApplicationRecord
  belongs_to :creator, class_name: "User", foreign_key: "user_id"
  has_many :reviews
  has_many :favorites
  has_many :users, through: :favorites
  has_many :points_of_interests
  has_many :locations, through: :points_of_interests
  has_many :hikes_categories
  has_many :categories, through: :hikes_categories
  include PgSearch::Model
  multisearchable against: [ :name, :description, :time, :distance ]
  pg_search_scope :hike_search,
                  against: [ :name, :description, :time, :distance ],
                  associated_against: {
                    categories: [:name],
                    locations: [:address, :description]
                  },
                  using: {
                    tsearch: { prefix: true }
                  }
end
