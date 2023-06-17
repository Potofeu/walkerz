class Category < ApplicationRecord
  has_many :hikes_categories
  has_many :hikes, through: :hikes_categories
end
