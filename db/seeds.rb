require 'faker'

puts 'Clearing database...'
HikesCategory.destroy_all
Category.destroy_all
Location.destroy_all
PointsOfInterest.destroy_all
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
20.times do
  hike = Hike.create!(
    name: Faker::Food.dish,
    description: Faker::Food.description,
    time: rand(1..8),
    distance: rand(3..20),
    user_id: User.all.sample.id
  )
  puts "Nouvelle balade: #{hike.name}"
end

puts "Putting categories in our hikes..."

30.times do
  HikesCategory.create!(
    hike_id: Hike.all.sample.id,
    category_id: Category.all.sample.id
  )
end

puts 'Creating locations...'
addresses = [
  "Pl. de l'Opéra, 75009 Paris",
  "Rue de la Petite Truanderie, 75001 Paris",
  "24 Rue de Sèvres, 75007 Paris",
  "1 Rue Pierre et Marie Curie, 75005 Paris",
  "261 Bd Raspail, 75014 Paris",
  "2 Pl. Joffre, 75007 Paris",
  "37 Rue Marbeuf, 75008 Paris",
  "158 Bd Haussmann, 75008 Paris",
  "64 Rue Sainte-Anne, 75002 Paris",
  "17 Rue Le Peletier, 75009 Paris"
 ]

addresses.each do |place|
  location = Location.create!(
    name: Faker::Fantasy::Tolkien.location,
    description: Faker::Quotes::Shakespeare.hamlet_quote,
    address: place
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
    content: Faker::Movies::StarWars.wookiee_sentence,
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
