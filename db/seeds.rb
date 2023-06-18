require 'faker'

puts 'Clearing database...'
Category.destroy_all
User.destroy_all
Hike.destroy_all

puts 'Creating categories !'
categories = ["Histoire", "Art", "Street art", "Immanquable", "Secret", "Food", "Politique"]

categories.each do |category|
  Category.create!(name: category)
  puts "Nouvelle catégorie: #{category}"
end

puts 'Creating users !'
User.create!(email: 'mickael@test.com', password: '123456', first_name: 'Mickael', last_name: 'LEWAGON')
User.create!(email: 'sabrina@test.com', password: '123456', first_name: 'Sabrina', last_name: 'LEWAGON')
User.create!(email: 'hugo@test.com', password: '123456', first_name: 'Hugo', last_name: 'LEWAGON')

puts 'Creating hikes !'
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

puts "Voici les comptes que vous pouvez utiliser:"
User.all do |user|
  puts "Email: #{user.email}"
  puts "MDP: 123456"
end
