class Location < ApplicationRecord
  has_many :points_of_interests
  has_may :hikes, through: :points_of_interests
  geocoded_by :address # je veux que geocoder se base du le champ address pour trouver les coordonnées
  after_validation :geocode, if: :will_save_change_to_address? # saisis les informations de geocoding si le modèle s'est sauvegardé correctement
end
