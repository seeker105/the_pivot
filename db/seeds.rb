
# byebug

# 6 Users
puts "Creating Users..."
admin = User.create!(username: "admin",
                     password: "admin",
                     email: "jcasimir@example.com",
                     name: "Jeff Casimir",
                     address: "1510 Blake St",
                     city: "Denver",
                     state: "CO",
                     zip: "80111")
jcasimir = User.create!(username: "jcasimir",
                        password: "test",
                        email: "jcasimir@example.com",
                        name: "Jeff Casimir",
                        address: "1510 Blake St",
                        city: "Denver",
                        state: "CO",
                        zip: "80111")
mdao = User.create!(username: "mdao",
                    password: "test",
                    email: "mdao@example.com",
                    name: "Mike Dao",
                    address: "1510 Denver St",
                    city: "Blake",
                    state: "CO",
                    zip: "80111")
neight = User.create!(username: "nate@turing.io",
                      password: "password",
                      email: "nate@turing.io",
                      name: "Nate Allen",
                      address: Faker::Address.street_address,
                      city: Faker::Address.city,
                      state: Faker::Address.state_abbr,
                      zip: Faker::Address.zip)
jorge = User.create!(username: "jorge@turing.io",
                     password: "password",
                     email: "jorge@turing.io",
                     name: "Jorge Tellez",
                     address: Faker::Address.street_address,
                     city: Faker::Address.city,
                     state: Faker::Address.state_abbr,
                     zip: Faker::Address.zip,
                     platform_admin: true)
jmejia = User.create!(username: "jmejia@turing.io",
                      password: "password",
                      email: "jmejia@turing.io",
                      name: "Josh Mejia",
                      address: Faker::Address.street_address,
                      city: Faker::Address.city,
                      state: Faker::Address.state_abbr,
                      zip: Faker::Address.zip)
94.times do
  User.create!(username: Faker::Internet.email,
               password: "password",
               email: Faker::Internet.email,
               name: Faker::Name.name,
               address: Faker::Address.street_address,
               city: Faker::Address.city,
               state: Faker::Address.state_abbr,
               zip: Faker::Address.zip)
end
puts "Created Users"

puts "Creating Businesses..."
Business.create!(name: Faker::Company.name,
                # description: Faker::Company.catch_phrase,
                owner: neight)
Business.create!(name: Faker::Company.name,
                # description: Faker::Company.catch_phrase,
                owner: neight)

18.times do
  Business.create!(name: Faker::Company.name,
                  # description: Faker::Company.catch_phrase,
                  owner_id: neight)
end
puts "Created Businesses"


puts "Creating Items & Categories..."
date = DateTime.now
storage = Category.create!(name: "Storage")
item_1 = storage.items.create!(name: "Laser Disc", description: "Make great plates.", price: "5.99", image: "https://visualhunt.com/photos/m/5/laser-and-video-discs-24.jpg", end_time: date.prev_day, status: 0, business_id: rand(1..19))
item_2 = storage.items.create!(name: "Floppy Disc", description: "Need to store a whopping 1.44 MB of data? This bad boy has got you covered.", price: "5.99", image: "https://visualhunt.com/photos/m/5/day-037-did-floppy-exist-once.jpg", end_time: date.prev_day, status: 0, business_id: rand(1..19))
item_3 = storage.items.create!(name: "CD", description: "Like ninja stars but better.", price: "2.99", image: "https://visualhunt.com/photos/m/4/cd-dvd-computer-data-shiny-digital-disk.jpg", end_time: date.prev_day, status: 0, business_id: rand(1..19))
7.times do
  storage.items.create!(name: Faker::Hacker.noun.capitalize,
                       description: Faker::Lorem.sentence,
                       price: Faker::Commerce.price,
                       image: "https://visualhunt.com/photos/m/4/cd-dvd-computer-data-shiny-digital-disk.jpg",
                       end_time: date.prev_day,
                       business_id: rand(1..19))
end
25.times do
  storage.items.create!(name: Faker::Hacker.noun.capitalize,
                       description: Faker::Lorem.sentence,
                       price: Faker::Commerce.price,
                       image: "https://visualhunt.com/photos/m/4/cd-dvd-computer-data-shiny-digital-disk.jpg",
                       end_time: date.next_day,
                       business_id: rand(1..19))
end
15.times do
  storage.items.create!(name: Faker::Hacker.noun.capitalize,
                       description: Faker::Lorem.sentence,
                       price: Faker::Commerce.price,
                       image: "https://visualhunt.com/photos/m/4/cd-dvd-computer-data-shiny-digital-disk.jpg",
                       end_time: date.next_day(2),
                       business_id: rand(1..19))
end


electronics = Category.create!(name: "Electronics")
item_4 = electronics.items.create!(name: "Walkman", description: "Enjoy some tunes on your walkman.", price: "22.99", image: "https://visualhunt.com/photos/m/5/sony-sports-walkman-wm-f5-okinawa.jpg", end_time: date.prev_day, status: 0, business_id: rand(1..19))
item_5 = electronics.items.create!(name: "VCR", description: "Now go find some VCR tapes!", price: "100.99", image: "https://visualhunt.com/photos/m/5/vcr.jpg", end_time: date.prev_day, status: 0, business_id: rand(1..19))
item_6 = electronics.items.create!(name: "Discman", description: "Listen to all your favorite hits.", price: "10.99", image: "https://c4.staticflickr.com/3/2318/2051407819_794a95d465_b.jpg", end_time: date.prev_day, status: 0, business_id: rand(1..19))
7.times do
  electronics.items.create!(name: Faker::Hacker.ingverb.capitalize,
                           description: Faker::Hacker.say_something_smart,
                           price: Faker::Commerce.price,
                           image: "https://visualhunt.com/photos/m/4/cd-dvd-computer-data-shiny-digital-disk.jpg",
                           end_time: date.prev_day,
                           business_id: rand(1..19))
end
25.times do
  electronics.items.create!(name: Faker::Hacker.ingverb.capitalize,
                           description: Faker::Hacker.say_something_smart,
                           price: Faker::Commerce.price,
                           image: "https://visualhunt.com/photos/m/4/cd-dvd-computer-data-shiny-digital-disk.jpg",
                           end_time: date.next_day,
                           business_id: rand(1..19))
end
15.times do
  electronics.items.create!(name: Faker::Hacker.ingverb.capitalize,
                           description: Faker::Hacker.say_something_smart,
                           price: Faker::Commerce.price,
                           image: "https://visualhunt.com/photos/m/4/cd-dvd-computer-data-shiny-digital-disk.jpg",
                           end_time: date.next_day(2),
                           business_id: rand(1..19))
end

game_systems = Category.create!(name: "Gaming")
item_7 = game_systems.items.create!(name: "Gameboy", description: "Remember discovering Tetris? Discover it again on this Gameboy.", price: "99.99", image: "https://c4.staticflickr.com/8/7481/16037341171_3db0f52a8d_k.jpg", end_time: date.prev_day, status: 0, business_id: rand(1..19))
item_8 = game_systems.items.create!(name: "Atari", description: "Take it back to the 80's and play some Atari on this mint condition system.", price: "800.99", image: "https://c5.staticflickr.com/8/7678/17513196036_a6b2e4889f_k.jpg", end_time: date.prev_day, status: 0, business_id: rand(1..19))
item_9 = game_systems.items.create!(name: "Nintendo", description: "Play some games on the original NES.", price: "1999.88", image: "https://visualhunt.com/photos/m/5/nintendo-nes.jpg", end_time: date.prev_day, status: 0, business_id: rand(1..19))
7.times do
  game_systems.items.create!(name: Faker::Hacker.verb.capitalize,
                            description: Faker::StarWars.quote,
                            price: Faker::Commerce.price,
                            image: "https://visualhunt.com/photos/m/4/cd-dvd-computer-data-shiny-digital-disk.jpg",
                            end_time: date.prev_day,
                            business_id: rand(1..19))
end
25.times do
  game_systems.items.create!(name: Faker::Hacker.verb.capitalize,
                            description: Faker::StarWars.quote,
                            price: Faker::Commerce.price,
                            image: "https://visualhunt.com/photos/m/4/cd-dvd-computer-data-shiny-digital-disk.jpg",
                            end_time: date.next_day,
                            business_id: rand(1..19))
end
15.times do
  game_systems.items.create!(name: Faker::Hacker.verb.capitalize,
                            description: Faker::StarWars.quote,
                            price: Faker::Commerce.price,
                            image: "https://visualhunt.com/photos/m/4/cd-dvd-computer-data-shiny-digital-disk.jpg",
                            end_time: date.next_day(2),
                            business_id: rand(1..19))
end

# 7 more categories

  Category.create!(name: "Movies")
  Category.create!(name: "Books")
  Category.create!(name: "Antiques")
  Category.create!(name: "Digital")
  Category.create!(name: "Analog")
  Category.create!(name: "Classic Cars")
  Category.create!(name: "Music & Audio")


(4..Category.count).step do |x|
  10.times do
    Category.find(x).items.create!(name: Faker::App.name.capitalize,
                                  description: Faker::Hipster.sentence,
                                  price: Faker::Commerce.price,
                                  image: "https://visualhunt.com/photos/m/4/cd-dvd-computer-data-shiny-digital-disk.jpg",
                                  end_time: date.prev_day,
                                  business_id: rand(1..19))
  end
  25.times do
    Category.find(x).items.create!(name: Faker::App.name.capitalize,
                                  description: Faker::Hipster.sentence,
                                  price: Faker::Commerce.price,
                                  image: "https://visualhunt.com/photos/m/4/cd-dvd-computer-data-shiny-digital-disk.jpg",
                                  end_time: date.next_day,
                                  business_id: rand(1..19))
  end
  15.times do
    Category.find(x).items.create!(name: Faker::App.name.capitalize,
                                  description: Faker::Hipster.sentence,
                                  price: Faker::Commerce.price,
                                  image: "https://visualhunt.com/photos/m/4/cd-dvd-computer-data-shiny-digital-disk.jpg",
                                  end_time: date.next_day(2),
                                  business_id: rand(1..19))
  end
end
puts "Created Categories & Items"
