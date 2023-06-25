require 'faker'
require "json"
require "open-uri"

puts 'Clearing database...'
HikesCategory.destroy_all
Category.destroy_all
PointsOfInterest.destroy_all
Location.destroy_all
Favorite.destroy_all
Review.destroy_all
Hike.destroy_all
User.destroy_all

puts 'Creating categories...'
categories = ["Histoire", "Art", "Street art", "Immanquable", "Secret", "Food", "Politique"]

categories.each do |category|
  Category.create!(name: category)
  puts "Nouvelle catégorie: #{category}"
end

puts 'Creating users...'
User.create!(email: 'mickael@test.com', password: '123456', first_name: 'Mickael', last_name: 'LEWAGON')
User.create!(email: 'sabrina@test.com', password: '123456', first_name: 'Sabrina', last_name: 'LEWAGON')
User.create!(email: 'hugo@test.com', password: '123456', first_name: 'Hugo', last_name: 'LEWAGON')

puts 'Creating hikes...'

names = ["Le moyen-âge à paris", "Paris food tour", "Les immanquables de la capitale", "Le paris secret", "Parcs et jardins"]
cities = ["Paris", "Lyon", "Marseille", "Lille", "Nantes", "Quimper", "Bordeaux", "Strasbourg"]
names.each do |name|
  hike = Hike.create!(
    name: name,
    description: Faker::Food.description,
    time: rand(1..8),
    distance: rand(3..20),
    city: cities.sample,
    user_id: User.all.sample.id
  )
  puts "Nouvelle balade: #{hike.name}"
end

puts "Putting categories in our hikes..."

10.times do
  HikesCategory.create!(
    hike_id: Hike.all.sample.id,
    category_id: Category.all.sample.id
  )
end

puts 'Creating locations...'

location_names = ["The french bastards - Oberkampf", "Place de la Bastille", "Jardin des Plantes", "Les Catacombes de Paris", "Chez Bébert"]
location_address = ["61 Rue Oberkampf, 75011 Paris", "Place de la Bastille, 75004 Paris", "57 Rue Cuvier, 75005 Paris", "1 Av. du Colonel Henri Rol-Tanguy, 75014 Paris", "71 Bd du Montparnasse, 75006 Paris"]
(0..4). each do |number|
    location = Location.create!(
      name: location_names[number],
      description: Faker::Quotes::Shakespeare.hamlet_quote,
      address: location_address[number]
    )
    puts "Nouvel endroit: #{location.name}"
end
puts "Creating Points of Interest..."
Hike.all.each do |hike|
  5.times do
    PointsOfInterest.create!(
      hike_id: hike.id,
      location_id: Location.all.sample.id,
      step: rand(1..5)
    )
  end
end

puts "Creating reviews..."
10.times do
  Review.create(
    content: Faker::Books::Lovecraft.sentence,
    rating: rand(1..5),
    user_id: User.all.sample.id,
    hike_id: Hike.all.sample.id
  )
end

puts "Creating Favorites..."

5.times do
  Favorite.create!(
    user_id: User.all.sample.id,
    hike_id: Hike.all.sample.id
  )
end
puts "Voici les comptes que vous pouvez utiliser:"
User.all.each do |user|
  puts "Email: #{user.email}"
  puts "MDP: 123456"
end
