class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :reviews
  has_many :favorites
  has_many :hikes
  has_many :achievements
  has_many :hikes_as_achievements, through: :achievements, source: :hikes
end
