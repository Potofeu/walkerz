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
category_1 = Category.create!(name: "Histoire")
category_2 = Category.create!(name: "Art")
category_3 = Category.create!(name: "Insolite")
category_4 = Category.create!(name: "Immanquable")
category_5 = Category.create!(name: "Secret")
category_6 = Category.create!(name: "Food")
category_7 = Category.create!(name: "Politique")
puts 'Categories OK'

puts 'Creating users...'
User.create!(email: 'mickael@test.com', password: '123456', first_name: 'Mickael', last_name: 'LEWAGON')
User.create!(email: 'sabrina@test.com', password: '123456', first_name: 'Sabrina', last_name: 'LEWAGON')
User.create!(email: 'hugo@test.com', password: '123456', first_name: 'Hugo', last_name: 'LEWAGON')
puts 'Users OK'

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

puts '-- Creating hike 2...'
hike_2 = Hike.create!(
  name: "Revivez la Résistance à Lyon",
  description: "Lyon a occupé une place très importante dans la Résistance durant l’Occupation allemande. Dès 1940,
  des personnes se regroupent, le plus souvent par connaissance, pour réfléchir aux moyens de poursuivre la lutte.
  Des premiers groupes naissent dans les cafés et les lieux de sociabilité habituels des Lyonnais. Ils sont rapidement
  aidés et rejoint par un grand nombre de personnes venues se réfugier à Lyon, soit dès 1940 lors de la débâcle soit
  ensuite. Ainsi, dès l'automne 1940, ce qui deviendra les plus importants mouvements se fondent à Lyon : Combat,
  Franc-Tireur et Libération. Nous vous proposons dans ce circuit de découvrir les lieux les plus marquants de cette
  histoire.",
  time: 8,
  distance: 15,
  city: "Lyon",
  user_id: User.all.sample.id
)
puts '-- Hike 2 OK'

puts '---- Adding categories for hike 2...'
HikesCategory.create!(
  hike_id: hike_2.id,
  category_id: category_1.id
)
HikesCategory.create!(
  hike_id: hike_2.id,
  category_id: category_5.id
)
HikesCategory.create!(
  hike_id: hike_2.id,
  category_id: category_7.id
)
HikesCategory.create!(
  hike_id: hike_2.id,
  category_id: category_4.id
)
puts '---- Categories for hike 2 OK'

puts '------ Creating locations related to hike 2...'
image_1 = "db/images/H2_Prison_Montluc.jpeg"
location_1 = Location.new(
  name: "Prison Montluc",
  description: "Prison militaire construite en 1921 sur les glacis du fort Montluc. Elle est particulièrement célèbre
  pour son rôle de lieu de détention pendant la Seconde Guerre mondiale. Plus de 10 000 personnes parmi lesquelles
  Jean Moulin et Marc Bloch ont transité par ce lieu entre le 17 février 1943 et le 24 août 1944.",
  address: "4 Rue Jeanne Hachette 69003 Lyon"
)
location_1.photo.attach(io: File.open(image_1), filename: "#{location_1.name}.jpg")
location_1.save!

image_2 = "db/images/H2_CHRD.jpg"
location_2 = Location.new(
  name: "CHRD Lyon",
  description: "Le Centre d'Histoire de la Résistance et de la Déportation (CHRD) est un musée de France situé dans la
  ville de Lyon. Il traite l'histoire de la Seconde Guerre mondiale. Les collections du CHRD se caractérisent par leur
  ancrage régional et les itinéraires personnels auxquels elles renvoient. Le fonds initial provenant de l’ancien musée
  de la rue Boileau est régulièrement enrichi par des dons de personnes privées et des acquisitions à titre onéreux.",
  address: "14 Avenue Berthelot 69007 Lyon"
)
location_2.photo.attach(io: File.open(image_2), filename: "#{location_2.name}.jpg")
location_2.save!

image_3 = "db/images/H2_Saint_Catherine.jpg"
location_3 = Location.new(
  name: "Rafle de la rue Sainte-Catherine",
  description: "e 9 février 1943, 86 Juifs ont été raflés par la Gestapo dirigée par Klaus Barbie, 12 rue
  Sainte-Catherine (Lyon 1er), au siège de la Fédération des sociétés juives de France et du comité́ d’assistance aux
  réfugiés, réunis au sein de l’Union générale des israélites de France. D’abord emprisonné au Fort Lamothe (Lyon 7e),
  le groupe est transféré au camp de Drancy le 12 février. Sur les 86 Juifs raflés à Lyon, 80 sont déportés dans les
  camps d’Auschwitz-Birkenau, Sobibor et Bergen-Belsen. En 1945, il demeure 4 survivants.
  En 2011, une plaque est apposée au 12 de la rue Sainte-Catherine par l’association des Fils et Filles des déportés
  juifs de France, en présence de Serge Klarsfeld et Robert Badinter.",
  address: "12 Rue Sainte-Catherine 69001 Lyon"
)
location_3.photo.attach(io: File.open(image_3), filename: "#{location_3.name}.jpg")
location_3.save!

image_4 = "db/images/H2_Memorial_JM.jpg"
location_4 = Location.new(
  name: "Mémorial Jean Moulin",
  description: "C'est dans cette maison, l'ancienne maison du Docteur Dugoujon, que Jean Moulin, représentant personnel
  du Général de Gaulle, chef des Mouvements unis de la Résistance et président du Conseil national de la Résistance,
  a été arrêté par Klaus Barbie et la Gestapo le 21 juin 1943 avec sept chefs de la Résistance de la zone Sud.",
  address: "2 Place Jean Gouailhardou 69300 Caluire-et-Cuir"
)
location_4.photo.attach(io: File.open(image_4), filename: "#{location_4.name}.jpg")
location_4.save!
puts '------ Locations for hike 2 OK'

puts '-------- Creating points of interest for hike 2...'
PointsOfInterest.create!(
  hike_id: hike_2.id,
  location_id: location_1.id,
  step: 1,
  description: location_1.description
)
PointsOfInterest.create!(
  hike_id: hike_2.id,
  location_id: location_2.id,
  step: 2,
  description: location_2.description
)
PointsOfInterest.create!(
  hike_id: hike_2.id,
  location_id: location_3.id,
  step: 3,
  description: location_3.description
)
PointsOfInterest.create!(
  hike_id: hike_2.id,
  location_id: location_4.id,
  step: 4,
  description: location_4.description
)
puts '-------- Points of interest for hike 2 OK'

puts '-- Creating hike 3...'
hike_3 = Hike.create!(
  name: "Nantes et l'Art Contemporain",
  description: "La politique culturelle de Nantes, menée depuis plus de 20 ans a fait passer la ville de « belle
  endormie », son surnom dans les années 1980, à l’avant-garde la plus pointue : en art contemporain (Estuaire puis
  Le Voyage à Nantes), en musique classique (La Folle Journée) ou en spectacles de rue géants (Royal de Luxe, Les
  Machines de l’Ile)",
  time: rand(1..8),
  distance: rand(3..20),
  city: "Nantes",
  user_id: User.all.sample.id
)
puts '-- Hike 3... OK'

puts '---- Adding categories for hike 3...'
HikesCategory.create!(
  hike_id: hike_3.id,
  category_id: category_2.id
)
HikesCategory.create!(
  hike_id: hike_3.id,
  category_id: category_3.id
)
HikesCategory.create!(
  hike_id: hike_3.id,
  category_id: category_4.id
)
puts '---- Categories for hike 3 OK'

puts '------ Creating locations related to hike 3...'

image_1 = "db/images/H3_Musee_Arts.jpg"
location_1 = Location.new(
  name: "Musée d’Arts de Nantes",
  description: "Essentiellement musée de peinture jusque dans les années 1980, le musée accueille toutes les formes de
  création de l’art ancien à l’art contemporain : peinture, vidéo, photographie ou installation. Des expositions
  temporaires et des activités culturelles viennent renforcer la collection permanente pour éclairer le visiteur sur
  l’œuvre d’un artiste ou une période historique.",
  address: "10 Rue Georges Clemenceau 44000 Nantes"
)
location_1.photo.attach(io: File.open(image_1), filename: "#{location_1.name}.jpg")
location_1.save!

image_2 = "db/images/H3_Atelier.jpg"
location_2 = Location.new(
  name: "L’Atelier",
  description: "Tout au long de l’année, L’atelier de la rue de Châteaubriand vous propose des expositions d’art
  contemporain. Peinture, sculpture, photographie… y sont à l’honneur ! Ce lieu accueille chaque année une dizaine
  d’expositions présentant des artistes nantais, régionaux, nationaux et internationaux. Ouvert le 28 novembre 2008,
  l’Atelier a accueilli plus de 70 000 visiteurs. 650 artistes y ont été présentés avec 11 associations nantaises
  partenaires du projet depuis l’ouverture jusqu’à aujourd’hui",
  address: "1 rue de Chateaubriand 44000 Nantes"
)
location_2.photo.attach(io: File.open(image_2), filename: "#{location_2.name}.jpg")
location_2.save!

image_3 = "db/images/H3_HAB.jpg"
location_3 = Location.new(
  name: "HAB Galerie",
  description: "Créée à l’initiative du Voyage à Nantes, la HAB Galerie est un lieu dédié à l’art contemporain.
  Elle accueille, dans ses 1 400 m2, deux expositions organisées par différentes institutions culturelles : le FRAC des
  Pays de la Loire au printemps et Le Voyage à Nantes pour une exposition estivale. La HAB Galerie, dédiée à la culture
  artistique, offre une diversité d’évènements éphémères.",
  address: "21 Quai des Antilles 44200 Nantes"
)
location_3.photo.attach(io: File.open(image_3), filename: "#{location_3.name}.jpg")
location_3.save!
puts '------ Locations for hike 3 OK'

puts '-------- Creating points of interest for hike 3...'
PointsOfInterest.create!(
  hike_id: hike_3.id,
  location_id: location_1.id,
  step: 1,
  description: location_1.description
)
PointsOfInterest.create!(
  hike_id: hike_3.id,
  location_id: location_2.id,
  step: 2,
  description: location_2.description
)
PointsOfInterest.create!(
  hike_id: hike_3.id,
  location_id: location_3.id,
  step: 3,
  description: location_3.description
)
puts '-------- Points of interest for hike 3 OK'

puts '-- Creating hike 4...'
hike_4 = Hike.create!(
  name: "Marseille fait son Cinéma",
  description: "Pour les Amateurs du 7e art, voici une invitation à plonger dans les décors naturels de scènes mythiques tournés
  dans la cité phocéenne ! Votre guide vous emmène de la Cathédrale de La Major au Vieux-Port en rythmant la visite avec
  des extraits. Au programme, des sagas comme Taxi, des films primés avec Marius et Jeannette, sans oublier des
  productions internationales comme La mémoire est dans la peau avec Matt Damon.)",
  time: 3,
  distance: 5,
  city: "Marseille",
  user_id: User.all.sample.id
)
puts '-- Hike 4... OK'

puts '---- Adding categories for hike 4...'
HikesCategory.create!(
  hike_id: hike_4.id,
  category_id: category_2.id
)
HikesCategory.create!(
  hike_id: hike_4.id,
  category_id: category_3.id
)
HikesCategory.create!(
  hike_id: hike_4.id,
  category_id: category_4.id
)
puts '---- Categories for hike 4 OK'

puts '------ Creating locations related to hike 4...'
image_1 = "db/images/H4_Cathedrale.jpg"
location_1 = Location.new(
  name: "Cathédrale La Major",
  description: "Dans une séquence de 'Love Actually' Jamie dépose Aurélia, ils se disent au revoir car il doit retourner
  en Angleterre. , on peut facilement reconnaitre l’endroit. L’arrière-plan nous permet de voir qu’il s’agit de la
  cathédrale de La Major, même si les lieux ont beaucoup changé depuis!",
  address: "Place de la Major 13002 Marseille"
)
location_1.photo.attach(io: File.open(image_1), filename: "#{location_1.name}.jpg")
location_1.save!

image_2 = "db/images/H4_Vieu_port.jpg"
location_2 = Location.new(
  name: "Le vieux Port",
  description: "Construit au XIXème siècle et qui a vu l’arrivée et le départ de milliers de personnes, comme par
  exemple, Louis Delga, personnage joué par Dustin Hoffmann dans le film «Papillon», ou encore Stan Laurel et Oliver
  Hardy pour leur dernière production. On y retrouve d'autres tournages très connus comme A bout de Souffle où
  Jean-Paul Belmondo, ou la célèbre trilogie de Marcel Pagnol, “Marius”, “Fanny” et “César”.",
  address: "23 place de la Joliette 13002 Marseille"
)
location_2.photo.attach(io: File.open(image_2), filename: "#{location_2.name}.jpg")
location_2.save!

image_3 = "db/images/H4_Panier.jpg"
location_3 = Location.new(
  name: "Le quartier du Panier",
  description: "Plongez au cœur du plus vieux quartier de Marseille. Pour profiter de ce quartier mythique, le meilleur
  moyen est de flâner jusqu’à se perdre dans les ruelles étroites. Retrouvez des lieux de tournage pour Le Transporteur
  3",
  address: "Rue du Panier 13002 Marseille"
)
location_3.photo.attach(io: File.open(image_3), filename: "#{location_3.name}.jpg")
location_3.save!

image_4 = "db/images/H4_Montee.jpg"
location_4 = Location.new(
  name: "Montée des Accoules",
  description: "Situé à l’entrée du Panier, la Montée des Accoules est le lieu de tournage préféré des productions
  nationales et internationales. Souvent utilisée pour réaliser quelques séquences dans des films ou séries, la montée
  d’escaliers est apparu dans Taxi 3, Fanny (2013) et prochainement dans la série Transatlantique sur Netflix.",
  address: "Montée des Accoules 13002 Marseille"
)
location_4.photo.attach(io: File.open(image_4), filename: "#{location_4.name}.jpg")
location_4.save!
puts '------ Locations for hike 4 OK'

puts '-------- Creating points of interest for hike 4...'
PointsOfInterest.create!(
  hike_id: hike_4.id,
  location_id: location_1.id,
  step: 1,
  description: location_1.description
)
PointsOfInterest.create!(
  hike_id: hike_4.id,
  location_id: location_2.id,
  step: 2,
  description: location_2.description
)
PointsOfInterest.create!(
  hike_id: hike_4.id,
  location_id: location_3.id,
  step: 3,
  description: location_3.description
)
PointsOfInterest.create!(
  hike_id: hike_4.id,
  location_id: location_4.id,
  step: 4,
  description: location_4.description
)
puts '-------- Points of interest for hike 4 OK'

puts '-- Creating hike 5...'
hike_5 = Hike.create!(
  name: "Visiter Bordeaux sous terre",
  description: "De Bordeaux, vous connaissez certainement les quais, les façades classées, le miroir d’eau… Mais
  savez-vous qu’un véritable trésor se cache sous vos pieds ? L’office de Tourisme de Bordeaux propose aux curieux de
  visiter ces parties secrète de la ville. De la crypte archéologique de Saint-Seurin, aux sous-sols inquiétants du
  Monuments aux Girondins, en passant par les fondations d’une ancienne tour romaine située à 15 m sous terre…
  Découvrez ces visites méconnues de Bordeaux.",
  time: 5,
  distance: 6,
  city: "Bordeaux",
  user_id: User.all.sample.id
)
puts '-- Hike 5... OK'

puts '---- Adding categories for hike 5...'
HikesCategory.create!(
  hike_id: hike_5.id,
  category_id: category_1.id
)
HikesCategory.create!(
  hike_id: hike_5.id,
  category_id: category_3.id
)
HikesCategory.create!(
  hike_id: hike_5.id,
  category_id: category_5.id
)
puts '---- Categories for hike 5 OK'

puts '------ Creating locations related to hike 5...'
image_1 = "db/images/H5_Crypte.jpg"
location_1 = Location.new(
  name: "Crypte de Saint-Seurin",
  description: "Découvrez les sous-terrains d'un site archéologique connu : le corps de saint Seurin (ou Séverin)
  repose-il bel et bien dans cette crypte ou non ? Car celui qui a donné son nom à la basilique actuelle donne du fil à
  retordre aux historiens dont certains en sont persuadés et d’autres émettent des doutes. On y trouve déjà de nombreux
  tombeaux dont ceux de sainte Véronique et de sainte Bénédicte ou encore le sarcophage primitif de saint Fort, en pierre
  brute, dressé majestueusement dans une alcôve de la crypte avec un cénotaphe à colonnes au XVIIe siècle.",
  address: "Place des Martyrs de la Résistance 33000 Bordeaux "
)
location_1.photo.attach(io: File.open(image_1), filename: "#{location_1.name}.jpg")
location_1.save!

image_2 = "db/images/H5_Fontaine.jpg"
location_2 = Location.new(
  name: "Monument aux Girondins",
  description: "Vous découvrirez l'histoire du Monument aux Girondins. Ici la structure intérieure de la colonne,
  la machinerie des fontaines, ainsi que les moules de certaines parties des statues, visibles au pied du monument.
  L’espace laissé par la destruction du château Trompette en 1816 permis en 1893 d’ériger une colonne, au sommet de
  laquelle on installe avantageusement la « Liberté brisant ses fers » afin de célébrer les valeurs de la République.",
  address: "Place des Quinconces 33000 Bordeaux"
)
location_2.photo.attach(io: File.open(image_2), filename: "#{location_2.name}.jpg")
location_2.save!

image_3 = "db/images/H5_Palais.jpg"
location_3 = Location.new(
  name: "Le Palais Gallien",
  description: "On n’entend plus le rugissement des fauves, non plus les cris glorieux des gladiateurs. Mais les ruines
  de cet amphithéâtre parlent encore  de Burdigala (le nom de Bordeaux à l’époque romaine) du temps où la cité était
  florissante. Une porte monumentale s’élève encore et quelques arcatures et départs de murs sont inclus dans les
  jardins, les maisons alentours et même dans les caves ! Sur ses gradins de bois, aujourd’hui disparus, 20000
  spectateurs (soit le double de la population de l’époque) pouvaient assister aux jeux. Au XVIIe siècle, le Palais
  Gallien servit de refuge aux truands et filles publiques… la rumeur en fit le rendez-vous des sorcières avant qu’un
  maire de la Révolution ne le transforme en carrière publique.",
  address: "144 Rue Abbé de l'Épée 33000 Bordeaux"
)
location_3.photo.attach(io: File.open(image_3), filename: "#{location_3.name}.jpg")
location_3.save!

puts '------ Locations for hike 5 OK'

puts '-------- Creating points of interest for hike 5...'
PointsOfInterest.create!(
  hike_id: hike_5.id,
  location_id: location_1.id,
  step: 1,
  description: location_1.description
)
PointsOfInterest.create!(
  hike_id: hike_5.id,
  location_id: location_2.id,
  step: 2,
  description: location_2.description
)
PointsOfInterest.create!(
  hike_id: hike_5.id,
  location_id: location_3.id,
  step: 3,
  description: location_3.description
)
puts '-------- Points of interest for hike 5 OK'

puts '-- Creating hike 6...'
hike_6 = Hike.create!(
  name: "Spécialités du Nord",
  description: "N’est pas lillois qui veut. Si vous n’avez pas passé l’épreuve du feu en goûtant au moins une fois dans
  votre vie chacune de ces 3 spécialités, l’origine lilloise ne vous est pas légalement pas accordée. Pour l’obtenir
  il vous suffit de finir ce parcours... Régalez-vous!",
  time: 8,
  distance: 5,
  city: "Lille",
  user_id: User.all.sample.id
)
puts '-- Hike 6... OK'

puts '---- Adding categories for hike 6...'
HikesCategory.create!(
  hike_id: hike_6.id,
  category_id: category_2.id
)
HikesCategory.create!(
  hike_id: hike_6.id,
  category_id: category_4.id
)
HikesCategory.create!(
  hike_id: hike_6.id,
  category_id: category_6.id
)
puts '---- Categories for hike 6 OK'

puts '------ Creating locations related to hike 6...'
image_1 = "db/images/H6_Welsh.jpg"
location_1 = Location.new(
  name: "L'îlot Bar",
  description: "Le welsh est aux lillois ce que la fondue est aux savoyards. La bière aux belges, les crêpes aux
  bretons, la crème aux normands… Bref, vous l’aurez compris : c’est LE plat nordiste par excellence.
  A L'îlot Bar le welsh y est bien présenté, pas trop huileux, la sauce à la moutarde bien relevée. De plus, il est fait
  à base de cheddar bien fondant Galloway du Nord de l’Écosse, et servi avec des frites maison. Des frites, des frites,
  des frites ! La technique, selon le gourou de l’Amicale des welsh, c’est de les tremper dans la sauce cheddar…
  On a rarement goûté un mets plus fin.",
  address: "253 rue Nationale 59800 Lille "
)
location_1.photo.attach(io: File.open(image_1), filename: "#{location_1.name}.jpg")
location_1.save!

image_2 = "db/images/H6_Carbonade.png"
location_2 = Location.new(
  name: "Estaminet Au Vieux De La Vieille",
  description: "La carbonnade flamande, comme son nom l’indique subtilement, est un plat typique du Nord. Il s’agit
  d’un ragoût de bœuf avec du lard fumé, des oignons caramélisés et de la bière brune. Situé en plein centre ville,
  le Barbu d'Anvers est caché dans une petite cour. Plats traditionnaux et cuisine généreuse sont au rendez-vous !
  Un lieu chaleureux à l'image de l'équipe, on vous invite à venir sans hésiter dans cet estaminet !",
  address: "2 Rue des Vieux Murs 59800 Lille"
)
location_2.photo.attach(io: File.open(image_2), filename: "#{location_2.name}.jpg")
location_2.save!

image_3 = "db/images/H6_Flamiche.png"
location_3 = Location.new(
  name: "Bierbuik",
  description: "La meilleure flamiche au Maroilles qu’on connaisse, c’est celle de Florent Ladeyn, finaliste de Top Chef
  2013. Retrouvez une cuisine 100% locale qui saura vous montrez la beauté du Nord!",
  address: "19 Rue Royale 59000 Lille"
)
location_3.photo.attach(io: File.open(image_3), filename: "#{location_3.name}.jpg")
location_3.save!

puts '------ Locations for hike 6 OK'

puts '-------- Creating points of interest for hike 6...'
PointsOfInterest.create!(
  hike_id: hike_6.id,
  location_id: location_1.id,
  step: 1,
  description: location_1.description
)
PointsOfInterest.create!(
  hike_id: hike_6.id,
  location_id: location_2.id,
  step: 2,
  description: location_2.description
)
PointsOfInterest.create!(
  hike_id: hike_6.id,
  location_id: location_3.id,
  step: 3,
  description: location_3.description
)
puts '-------- Points of interest for hike 6 OK'

puts '-- Creating hike 7...'
hike_7 = Hike.create!(
  name: "Art et Histoire à Reims",
  description: "Ce tour de Reims va vous faire découvrir un patrimoine exceptionnel, dont plusieurs sites classés à
  l’UNESCO et une culture locale exceptionnelle à travers l'Art et l'Histoire de la région. Revivez l'histoire de France
  grâce à cette visite des lieux les plus importants de la ville alsacienne.",
  time: 7,
  distance: 10,
  city: "Reims",
  user_id: User.all.sample.id
)
puts '-- Hike 7... OK'

puts '---- Adding categories for hike 7...'
HikesCategory.create!(
  hike_id: hike_7.id,
  category_id: category_1.id
)
HikesCategory.create!(
  hike_id: hike_7.id,
  category_id: category_2.id
)
HikesCategory.create!(
  hike_id: hike_7.id,
  category_id: category_4.id
)
HikesCategory.create!(
  hike_id: hike_7.id,
  category_id: category_7.id
)
puts '---- Categories for hike 7 OK'

puts '------ Creating locations related to hike 7...'
image_1 = "db/images/H7_Cathedrale.jpg"
location_1 = Location.new(
  name: "Cathédrale Notre-Dame",
  description: "La Cathédrale Notre Dame est un chef-d'oeuvre de l'art gothique édifié à partir de 1211. Fortement
  endommagée pendant la première guerre mondiale, elle comporte une prouesse architecturale du XXe siècle : une
  charpente en béton armé élaborée par l'achitectre Henri Deneux, ainsi qu'un riche ensemble de vitraux contemporains
  dont certains contemporains dessinés par Marc Chagall (1974) et Imi Knoebel (2011 et 2015).",
  address: "Place du Cardinal Luçon 51100 Reims "
)
location_1.photo.attach(io: File.open(image_1), filename: "#{location_1.name}.jpg")
location_1.save!

image_2 = "db/images/H7_Basilique.jpg"
location_2 = Location.new(
  name: "La basilique Saint-Remi",
  description: "Après la cathédrale, qu'elle égale presque en taille, la basilique Saint-Remi est l'église la plus
  célèbre de Reims. De style romano-gothique, elle est l'une des plus remarquables réalisations de l'art roman dans le
  Nord de la France. Longue de 126 m, elle impressionne par sa profondeur et le sentiment d'intimité qu'elle procure.
  Construite au XIe siècle, elle abrite la sainte ampoule ainsi que les reliques de Saint-Remi,
  l'évêque qui baptisa Clovis en 498. Son tombeau (1847) occupe le centre du chœur. La sobre nef romane et le chœur
  gothique (fin du XIIe siècle) à quatre étages constituent un ensemble impressionnant de légèreté et d'harmonie.
  La façade fut construite en même temps que le chœur. ",
  address: "1 rue Simon 51100 Reims"
)
location_2.photo.attach(io: File.open(image_2), filename: "#{location_2.name}.jpg")
location_2.save!

image_3 = "db/images/H7_Champagne.jpg"
location_3 = Location.new(
  name: "Champagne Taittinger",
  description: "Le terroir champenois, à travers le champagne regorge de richesses, de secrets et d’anecdotes. Secrets
  de Champagne vous invite dans l’univers de la Champagne, pour découvrir ce qui bâtit sa renommée depuis des siècles :
  son terroir, le travail de la vigne, l’élaboration du Champagne, les outils d’antan et les expressions champenoises.
  16 maisons de champagne sont présentes dans la ville de Reims parmi lesquelles de grands noms de renommée
  internationale, dont la maison Taittinger.",
  address: "9 place Saint-Nicaise 51100 Reims"
)
location_3.photo.attach(io: File.open(image_3), filename: "#{location_3.name}.jpg")
location_3.save!

image_4 = "db/images/H7_Tau.jpg"
location_4 = Location.new(
  name: "Palais du Tau",
  description: "Au début du Vème siècle, le christianisme devient religion de l’État. Saint Nicaise, onzième évêque de
  Reims s'y installe et fait bâtir une cathédrale dédiée à Notre-Dame. Le palais du Tau, construit dans la partie sud
  du quartier cathédral, devient lieu de résidence de l'archevêque. Il est aussi le siège du pouvoir temporel de ce
  dernier qui est le principal seigneur de la ville de Reims et du pays rémois. À partir du XIIIème siècle, il porte
  le titre de duc et premier pair de France faisant de lui un grand vassal de la Couronne de France.",
  address: "6 rue Rockefeller 51100 Reims "
)
location_4.photo.attach(io: File.open(image_4), filename: "#{location_4.name}.jpg")
location_4.save!

puts '------ Locations for hike 7 OK'

puts '-------- Creating points of interest for hike 7...'
PointsOfInterest.create!(
  hike_id: hike_7.id,
  location_id: location_1.id,
  step: 1,
  description: location_1.description
)
PointsOfInterest.create!(
  hike_id: hike_7.id,
  location_id: location_2.id,
  step: 2,
  description: location_2.description
)
PointsOfInterest.create!(
  hike_id: hike_7.id,
  location_id: location_3.id,
  step: 3,
  description: location_3.description
)
PointsOfInterest.create!(
  hike_id: hike_7.id,
  location_id: location_4.id,
  step: 4,
  description: location_4.description
)
puts '-------- Points of interest for hike 7 OK'

puts '-- Creating hike 8...'
hike_8 = Hike.create!(
  name: "Paris food tour",
  description: "Vous avez envie de passer un moment unique dans un cadre idyllique ? Partez à la découverte de
  restaurants insolites et immanquables dans Paris. Ces établissements à la décoration incroyable, tantôt luxuriante,
  tantôt chic ou encore historique sauront vous faire passer un moment unique. Il faut dire que la capitale ne manque
  pas de belles adresses, circuit à découvrir sans tarder.",
  time: 6,
  distance: 4,
  city: "Paris",
  user_id: User.all.sample.id
)
puts '-- Hike 8... OK'

puts '---- Adding categories for hike 8...'
HikesCategory.create!(
  hike_id: hike_8.id,
  category_id: category_2.id
)
HikesCategory.create!(
  hike_id: hike_8.id,
  category_id: category_3.id
)
HikesCategory.create!(
  hike_id: hike_8.id,
  category_id: category_4.id
)
HikesCategory.create!(
  hike_id: hike_8.id,
  category_id: category_6.id
)
puts '---- Categories for hike 8 OK'

puts '------ Creating locations related to hike 8...'
image_1 = "db/images/H8_Bastards.jpg"
location_1 = Location.new(
  name: "The french bastards - Oberkampf",
  description: "les fondateurs font le pari d’une boulangerie à l’identité très marquée, ambiance 90’s à fond. En
  entrant, nos yeux s’orientent vers la décoration du lieu, originale et personnelle, qui met en exergue les goûts
  des garçons. Sur les étagères en face du comptoir, un vinyle de Big Fish, des figurines Dragon Ball Z, des livres
  sur Burning man… Un parfum de nostalgie adolescente. On salue d’abord la qualité des nombreuses viennoiseries au
  choix, ultra régressives : on fond d’amour pour la babka, brioche tressée au chocolat, généreusement tranchée,
  tellement moelleuse en bouche... bref REGALEZ-VOUS!",
  address: "61 Rue Oberkampf 75011 Paris"
)
location_1.photo.attach(io: File.open(image_1), filename: "#{location_1.name}.jpg")
location_1.save!

image_2 = "db/images/H8_Kodawari.jpg"
location_2 = Location.new(
  name: "Kodawari Ramen Tsukiji",
  description: "Le Kodawari Ramen Tsukiji vous offre un véritable voyage au Japon : vous y dégusterez de bons ramens
  dans un décor qui a voulu reproduire le marché aux poissons de Tsukiji à Tokyo (que j’avais d’ailleurs découvert
  lors de mon premier voyage au Japon). Tout a été pensé pour rendre l’expérience la plus immersive possible, avec
  même des caisses de faux poissons entre les tables (et ce qui est cool, c’est qu’on a pas l’odeur !).",
  address: "12 rue Richelieu 75001 Paris"
)
location_2.photo.attach(io: File.open(image_2), filename: "#{location_2.name}.jpg")
location_2.save!

image_3 = "db/images/H8_Bustronome.jpg"
location_3 = Location.new(
  name: "Le Bustronome",
  description: "Pour redécouvrir Paris de manière insolite, en jouant au touriste mais en mangeant tout de même un bon
  repas, je vous propose de découvrir Le Bustronome, un bus gastronomique à l’impériale qui vous fait voyager dans Paris
  pendant les 2 heures de votre repas. Grâce au toit en verre du bus, on peut profiter pleinement du paysage :
  Arc de Triomphe, Tour Eiffel, Grand Palais, Musée du Louvre, Opéra Garnier… On fait le tour des grands classiques
  parisiens, et pendant ce temps on profite d’un menu en 4 services plutôt sympa (entrée, plat de poisson, plat de
  viande, dessert).",
  address: "2 Avenue Kléber 75016 Paris"
)
location_3.photo.attach(io: File.open(image_3), filename: "#{location_3.name}.jpg")
location_3.save!

image_4 = "db/images/H8_Dragon.jpg"
location_4 = Location.new(
  name: "Le Wagon Bleu",
  description: "Manger dans un ancien wagon de l’Orient Express, et qui plus est un wagon qui est apparu dans le film
  La Grande Vadrouille avec Louis de Funès et Bourvil : c’est aussi possible à Paris ! Pour cela, direction le
  restaurant Le Wagon Bleu, dont les fenêtres donnent sur les voies de chemin de fer menant à la Gare Saint-Lazare.
  On entre d’abord dans la partie café, classique, avant de pénétrer dans la partie restaurant installée dans ce vieux
  wagon retapé. Etrangement, c’est un restaurant de cuisine corse (pas ce à quoi on s’attend de base dans ce genre de
  cadre !). Bonne charcuterie corse, plats sans plus. Mais le bon côté, c’est que niveau prix, cette expérience est
  accessible à tous.",
  address: "7 Rue Boursault 75017 Paris"
)
location_4.photo.attach(io: File.open(image_4), filename: "#{location_4.name}.jpg")
location_4.save!

puts '------ Locations for hike 8 OK'

puts '-------- Creating points of interest for hike 8...'
PointsOfInterest.create!(
  hike_id: hike_8.id,
  location_id: location_1.id,
  step: 1,
  description: location_1.description
)
PointsOfInterest.create!(
  hike_id: hike_8.id,
  location_id: location_2.id,
  step: 2,
  description: location_2.description
)
PointsOfInterest.create!(
  hike_id: hike_8.id,
  location_id: location_3.id,
  step: 3,
  description: location_3.description
)
PointsOfInterest.create!(
  hike_id: hike_8.id,
  location_id: location_4.id,
  step: 4,
  description: location_4.description
)
puts '-------- Points of interest for hike 8 OK'

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
