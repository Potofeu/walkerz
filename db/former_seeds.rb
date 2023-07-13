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
categories = ["Histoire", "Art", "Insolite", "Immanquable", "Secret", "Food", "Politique"]

categories.each do |category|
  Category.create!(name: category)
  puts "Nouvelle catégorie: #{category}"
end

puts 'Creating users...'
User.create!(email: 'mickael@test.com', password: '123456', first_name: 'Mickael', last_name: 'LEWAGON')
User.create!(email: 'sabrina@test.com', password: '123456', first_name: 'Sabrina', last_name: 'LEWAGON')
User.create!(email: 'hugo@test.com', password: '123456', first_name: 'Hugo', last_name: 'LEWAGON')

puts 'Creating hikes...'

# names = ["Le moyen-âge à paris", "Paris food tour", "Les immanquables de la capitale", "Le paris secret", "Parcs et jardins"]
# cities = ["Paris", "Lyon", "Marseille", "Lille", "Nantes", "Quimper", "Bordeaux", "Strasbourg"]
# names.each do |name|
#   hike = Hike.create!(
#     name: name,
#     description: Faker::Food.description,
#     time: rand(1..8),
#     distance: rand(3..20),
#     city: cities.sample,
#     user_id: User.all.sample.id
#   )
#   puts "Nouvelle balade: #{hike.name}"
# end

hike_1 = {
  name: "Le moyen-âge à paris",
  description: "Balade dans la mémoire du Paris médiéval, avec des lieux connus ou insolites à (re)découvrir. Le XIIIe
  siècle marque un tournant pour la capitale et les Parisiens. Et pour cause, cette période de grande prospérité verra
  naître quelques-uns des plus grands édifices que nous connaissons aujourd’hui : la cathédrale Notre-Dame, la Sainte
  Chapelle, le premier marché couvert des Halles ou encore le Palais de la Cité, dont certains vestiges nous sont
  arrivés par le biais de la Conciergerie.",
  time: rand(1..8),
  distance: rand(3..20),
  city: "Paris",
  user_id: User.all.sample.id
}

hike_2 = {
  name: "Paris food tour",
  description: "Vous avez envie de passer un moment unique dans un cadre idyllique ? Partez à la découverte des plus
  beaux restaurants de Paris, ces établissements à la décoration incroyable, tantôt luxuriante, tantôt chic ou encore
  historique. Il faut dire que la capitale ne manque pas de belles adresses, circuit à découvrir sans tarder. ",
  time: rand(1..8),
  distance: rand(3..20),
  city: "Paris",
  user_id: User.all.sample.id
}

hike_3 = {
  name: "Les immanquables de la Capitale",
  description: "Paris possède un patrimoine historique et culturel incomparable. Monuments emblématiques, musées et
  collections incontournables, châteaux, palais… la liste est longue ! Pour être sûr de ne rien manquer de votre visite
  dans la plus belle ville du monde, voici un circuit des incontournables qu'il faut absolument avoir vu au moins
  une fois.",
  time: rand(1..8),
  distance: rand(3..20),
  city: "Paris",
  user_id: User.all.sample.id
}

hike_4 = {
  name: "Revivez la Résistance à Lyon",
  description: "Lyon a occupé une place très importante dans la Résistance durant l’Occupation allemande. Nous vous
  proposons dans ce circuit de découvrir les lieux les plus marquants de cette histoire : Prison Montluc, Mémorial Jean
  Moulin, Centre d’Histoire de la Résistance et de la Déportation (CHRD), Rafle de la rue Sainte Catherine et Le Veilleur
  de pierre.",
  time: rand(1..8),
  distance: rand(3..20),
  city: "Lyon",
  user_id: User.all.sample.id
}

hike_5 = {
  name: "Le Strasbourg insolite",
  description: "Envie de découvrir le Strasbourg insolite? Si vous avez déjà visité les incontournables de Strasbourg et
  recherchez des idées d’activités plus originales à faire dans la capitale alsacienne, ce circuit est fait pour vous!
  J'ai regroupé ici des idées pour explorer Strasbourg autrement: il y en a pour tous les goûts en envies!",
  time: rand(1..8),
  distance: rand(3..20),
  city: "Strasbourg",
  user_id: User.all.sample.id
}

hike_6 = {
  name: "Nantes et l'Art Contemporain",
  description: "La politique culturelle de Nantes, menée depuis plus de 20 ans a fait passer la ville de « belle
  endormie », son surnom dans les années 1980, à l’avant-garde la plus pointue : en art contemporain (Estuaire puis
    Le Voyage à Nantes), en musique classique (La Folle Journée) ou en spectacles de rue géants (Royal de Luxe,
      Les Machines de l’Ile)",
  time: rand(1..8),
  distance: rand(3..20),
  city: "Nantes",
  user_id: User.all.sample.id
}

hike_7 = {
  name: "Marseille fait son Cinéma",
  description: "LAmateurs du 7e art, voici une invitation à plonger dans les décors naturels de scènes mythiques tournés
  dans la cité phocéenne ! Votre guide vous emmène de la Cathédrale de La Major au Vieux-Port en rythmant la visite avec
  des extraits. Au programme, des sagas comme Taxi, des films primés avec Marius et Jeannette, sans oublier des
  productions internationales comme La mémoire est dans la peau avec Matt Damon.)",
  time: rand(1..8),
  distance: rand(3..20),
  city: "Marseille",
  user_id: User.all.sample.id
}

hike_8 = {
  name: "Visiter Bordeaux sous terre",
  description: "De Bordeaux, vous connaissez certainement les quais, les façades classées, le miroir d’eau… Mais
  savez-vous qu’un véritable trésor se cache sous vos pieds ? L’office de Tourisme de Bordeaux propose aux curieux de
  visiter ces parties secrète de la ville. De la crypte archéologique de Saint-Seurin, aux sous-sols inquiétants du
  Monuments aux Girondins, en passant par les fondations d’une ancienne tour romaine située à 15 m sous terre…
  Découvrez ces visites méconnues de Bordeaux.",
  time: rand(1..8),
  distance: rand(3..20),
  city: "Bordeaux",
  user_id: User.all.sample.id
}

hike_9 = {
  name: "Spécialités du Nord",
  description: "N’est pas lillois qui veut. Si vous n’avez pas passé l’épreuve du feu en goûtant au moins une fois dans
  votre vie chacune de ces 5 spécialités, l’origine lilloise ne vous est pas légalement pas accordée. Pour l’obtenir
  il vous suffit de finir ce parcours... Régalez-vous!",
  time: rand(1..8),
  distance: rand(3..20),
  city: "Lille",
  user_id: User.all.sample.id
}

hike_10 = {
  name: "Art et Histoire à Reims",
  description: "Ce tour de Reims va vous faire découvrir un patrimoine exceptionnel, dont plusieurs sites classés à
  l’UNESCO et une culture locale exceptionnelle à travers l'Art et l'Histoire de la région.",
  time: rand(1..8),
  distance: rand(3..20),
  city: "Reims",
  user_id: User.all.sample.id
}

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
images = ["db/images/The-French-Bastards-Bakery-pastry-shop-Paris-France-12.jpg", "db/images/place de la bastille.jpg", "db/images/604143-le-jardin-des-plantes.jpg", "db/images/PARIS-Catacombes-de-Paris.jpg", "db/images/chez-bebert-montparnasse-facade.jpg"]
(0..4). each do |number|
  location = Location.new(
    name: location_names[number],
    description: Faker::Quotes::Shakespeare.hamlet_quote,
    address: location_address[number]
  )
  location.photo.attach(io: File.open(images[number]), filename: "#{location.name}.jpg")
  location.save!
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


#template new seed:

puts '-- Creating hike 1...'
hike_1 = Hike.create!(
  name: "Le moyen-âge à paris",
  description: "Balade dans la mémoire du Paris médiéval, avec des lieux connus ou insolites à (re)découvrir. Le XIIIe
  siècle marque un tournant pour la capitale et les Parisiens. Et pour cause, cette période de grande prospérité verra
  naître quelques-uns des plus grands édifices que nous connaissons aujourd’hui : la cathédrale Notre-Dame, la Sainte
  Chapelle, le premier marché couvert des Halles ou encore le Palais de la Cité, dont certains vestiges nous sont
  arrivés par le biais de la Conciergerie.",
  time: 2,
  distance: 3,
  city: "Paris",
  user_id: User.all.sample.id
)
puts '-- Hike 1... OK'

puts '---- Adding categories for hike 1...'
HikesCategory.create!(
  hike_id: hike_1.id,
  category_id: category_1.id
)
HikesCategory.create!(
  hike_id: hike_1.id,
  category_id: category_5.id
)
HikesCategory.create!(
  hike_id: hike_1.id,
  category_id: category_7.id
)
puts '---- Categories for hike 1 OK'

puts '------ Creating locations related to hike 1...'
image_1 = "db/images/H1_Notre-Dame_de_Paris.jpg"
location_1 = Location.new(
  name: "Cathédrale Notre-Dame",
  description: "Dès le XIIe siècle, un autel dédié à Marie est adossé au pilier sud-est de la cathédrale. Cet
  emplacement est un haut lieu de dévotion depuis le Moyen Age. Au XIXe siècle, Viollet-le-Duc y place une statue de
  la Vierge à l’enfant appelée depuis « Notre Dame de Paris ».",
  address: "6 Parvis Notre-Dame – Place Jean-Paul II 75004 Paris"
)
location_1.photo.attach(io: File.open(image_1), filename: "#{location_1.name}.jpg")
location_1.save!

image_2 = "db/images/H1_Saint_Chapelle.jpg"
location_2 = Location.new(
  name: "La Sainte-Chapelle",
  description: "Précieux vestige du palais royal de la Cité, la Sainte-Chapelle est édifiée au milieu du XIIIe siècle
  par Louis IX, futur Saint Louis, pour abriter les plus prestigieuses reliques de la Passion du Christ : la Couronne
  d’épines et le fragment de la Vraie Croix. Réalisée en moins de 7 ans, un temps record, la Sainte-Chapelle est conçue
  telle une pièce d’orfèvrerie, dont les murs de lumière exaltent la monarchie capétienne et le royaume de France.",
  address: "Place Dauphine 75001 Paris"
)
location_2.photo.attach(io: File.open(image_2), filename: "#{location_2.name}.jpg")
location_2.save!

image_3 = "db/images/H1_Halles.jpg"
location_3 = Location.new(
  name: "Premier marché des Halles",
  description: "En 1137, Louis VI décide de créer un marché en remplacement du marché Palu dans l’île de la Cité et de
  celui de la place de Grève. Le choix des Champeaux (« Petits Champs »), aux portes de la ville et au croisement de
  trois voies importantes, la rue Saint-Denis, la rue Montmartre et la rue Saint-Honoré paraît logique et le marché
  d’abord en plein air, va se développer rapidement.",
  address: "Allée Jules Supervielle 75001 Paris"
)
location_3.photo.attach(io: File.open(image_3), filename: "#{location_3.name}.jpg")
location_3.save!

image_4 = "db/images/H1_Palais_de_la_cite.jpg"
location_4 = Location.new(
  name: "Le palais de la Cité",
  description: " Le palais de la Cité a été la résidence des rois de France durant quatre siècles. Il ne subsiste de ce
  palais médiéval que la salle des Gardes et la grande salle des Gens d'armes érigées sous Philippe le Bel ainsi que les
  cuisines édifiées sous le Roi Jean le Bon. Les rois de France délaissent le lieu à la fin du XIVe siècle pour
  s'installer au Louvre et à Vincennes. Les lieux ont été transformés en palais de justice durant le XIXe siècle.",
  address: "2 boulevard du Palais 75001 Paris"
)
location_4.photo.attach(io: File.open(image_4), filename: "#{location_4.name}.jpg")
location_4.save!

puts '------ Locations for hike 1 OK'

puts '-------- Creating points of interest for hike 1...'
PointsOfInterest.create!(
  hike_id: hike_1.id,
  location_id: location_1.id,
  step: 1,
  description: location_1.description
)
PointsOfInterest.create!(
  hike_id: hike_1.id,
  location_id: location_2.id,
  step: 3,
  description: location_2.description
)
PointsOfInterest.create!(
  hike_id: hike_1.id,
  location_id: location_4.id,
  step: 2,
  description: location_4.description
)
PointsOfInterest.create!(
  hike_id: hike_1.id,
  location_id: location_3.id,
  step: 4,
  description: location_3.description
)
puts '-------- Points of interest for hike 1 OK'
