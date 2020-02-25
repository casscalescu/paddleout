# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

CATEGORY = %w(Shortboard Longboard Funboard Hybrid Other)
PRICE_DURATION = %w(Hour Day Week)
SKILL_LEVEL = %w(Beginner Intermediate Advanced Expert)
WAVE_SIZE = %w(1-3 4-6 7-10 10+)
WAVE_TYPE = %w(Reef Pointbreak Beachbreak)
FIN_TYPE = ['Single-fin', 'Twin', 'Tri/thruster', 'Quad', 'Other']
SURF_BRAND =  ["Jason Stevenson", "Channel Islands", "Firewire", "Rusty Surfboards", "Lost Surfboards", "Rip Curl", "Cannibal", "O'Neill"]
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
20.times do
  User.create!(
    email: Faker::Internet.email,
    username: Faker::Internet.username(specifier: 5),
    description: "Now this is a description :))))))))",
    photo: Faker::Avatar.image,
    password: Faker::Internet.password
  )
end


10.times do
  Surfboard.create!(
    user_id: rand(1..User.count),
    brand: SURF_BRAND.sample,
    price: rand(10..50),
    photo: Faker::Avatar.image,
    category: CATEGORY.sample,
    title: Faker::Hipster.sentences(number: 1),
    price_duration: PRICE_DURATION.sample,
    description: Faker::Hipster.sentences(number: 3),
    wave_type: WAVE_TYPE.sample,
    board_dimensions: "#{rand(190...250)}cm's long",
    fin_type: FIN_TYPE.sample,
    deposit: rand(100...300),
    skill_level: SKILL_LEVEL.sample,
    wave_size: WAVE_SIZE.sample,
    location: Faker::Address.full_address
  )
end


10.times do
  surf_id = rand(1..Surfboard.count)
  surf_board = Surfboard.find(surf_id)
  time_amount = surf_board.price_duration
  if time_amount == "Day"
    time_devise = 86400
  elsif time_amount == "Week"
    time_devise = 604800
  else
    time_devise = 3600
  end
  amount = surf_board.price
  date_end = rand(10.days.from_now..12.days.from_now)
  date_start = rand(7.days.from_now..9.days.from_now)
  Booking.create!(
    surfboard_id: surf_id,
    user_id: (0..User.count).grep_v(0).grep_v(surf_board.user_id).sample,
    start_date: date_start,
    end_date: date_end,
    total_price: (((date_end - date_start) / time_devise) * amount).round(2)
  )
end



