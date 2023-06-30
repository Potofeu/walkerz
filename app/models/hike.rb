class Hike < ApplicationRecord
  belongs_to :creator, class_name: "User", foreign_key: "user_id"
  has_many :reviews
  has_many :favorites
  has_many :users, through: :favorites
  has_many :points_of_interests
  has_many :locations, through: :points_of_interests
  has_many :hikes_categories
  has_many :categories, through: :hikes_categories
  validates :name, presence: true
  validates :time, presence: true
  validates :distance, presence: true
  validates :city, presence: true
  include PgSearch::Model
  multisearchable against: [ :name, :description, :time, :distance ]
  pg_search_scope :hike_search,
                  against: [ :name, :description, :time, :distance, :city ],
                  associated_against: {
                    categories: [:name],
                    locations: [:address, :description]
                  },
                  using: {
                    tsearch: { prefix: true }
                  }

  def user_favorite(user)
    favorites.find_by(user: user)
  end
end
