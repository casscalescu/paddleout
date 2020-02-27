# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
require "open-uri"
require "pry-byebug"


puts 'Clearing database'
Booking.destroy_all
Surfboard.destroy_all
User.destroy_all

SURF_BOARD_CONDITION = ["Excellent","Very Good","Good","Alright","Fairly ok"]
EXCUSE = ["Sufboard is never used as i am always busy","Dont surf as much as i would like to","Surfboard is owned by my partner and they are away","Surfboard is owned by my daughter and she is away at University","Surfboard is owned by my son and he is away on Holiday"]
CATEGORY = %w(Shortboard Longboard Funboard Hybrid Other)
SKILL_LEVEL = ["Beginner", "Up To Intermediate", "up To Advanced", "Up To Expert"]
WAVE_SIZE = ["Up to 3ft", "Up to 5ft", "Up to 7ft", "Up to 10ft", "Up to and more than 10ft"]
WAVE_TYPE = %w(Reef Pointbreak Beachbreak)
FIN_TYPE = ['Single-fin', 'Twin', 'Tri/thruster', 'Quad', 'Other']
SURF_BRAND =  ["Jason Stevenson", "Channel Islands", "Firewire", "Rusty Surfboards", "Lost Surfboards", "Rip Curl", "Cannibal", "O'Neill"]
SURF_URL = ["https://img.cleanlinesurf.com/catalog/product/cache/1/image/650x650/9df78eab33525d08d6e5fb8d27136e95/f/r/frwtsubm.jpg", "https://www.alpinebeach.com.au/wp-content/uploads/2019/04/1314.jpg","https://www.vertigosurf.com/wp-content/uploads/2019/11/20191116_091344.jpg", "https://www.alpinebeach.com.au/wp-content/uploads/2019/04/1009.jpg","https://coopersboardstore.com.au/wp-content/uploads/2018/12/blak-box-iii-squash-bottom-js-industries-surfboards.jpg", "https://stabmag.com/assets/Uploads/Eye-Symmetry-lucid-eye-aquiva-surf-back-1024x1024.jpg", "https://images-na.ssl-images-amazon.com/images/I/51I8g09VN1L._AC_SL1050_.jpg","https://www.surfindustries.com/images/cat-prod-3-palms-18-soft-surfboard.jpg"]
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Creating users'
puts 'Creating surfboards'
15.times do
  new_user = User.create!(
    email: Faker::Internet.email,
    username: Faker::Internet.username(specifier: 5),
    description: "#{EXCUSE.sample}",
    # photo: Faker::Avatar.image,
    password: 'password'
  )
  url = "https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png"
  file = URI.open(url)
  new_user.photo.attach(io: file, filename: 'user.png', content_type: 'image/png')

  puts "User Email - #{new_user.email}"

  1.times do
    new_surfboard = Surfboard.new(
      user: new_user,
      brand: SURF_BRAND.sample,
      price: rand(30..70),
      category: CATEGORY.sample,
      wave_type: WAVE_TYPE.sample,
      board_dimensions: rand(182...220),
      fin_type: FIN_TYPE.sample,
      deposit: rand(100...300),
      skill_level: SKILL_LEVEL.sample,
      wave_size: WAVE_SIZE.sample,
      longitude: rand(144.931..145.001),
      latitude: rand(-37.873..-37.798)
    )
    new_surfboard.title = "#{new_surfboard.brand} Surfboard, #{new_surfboard.board_dimensions}cm's long"
    new_surfboard.description = "In #{SURF_BOARD_CONDITION.sample} condition, #{new_user.description}, only $#{new_surfboard.price} per day, any questions let me know at 04#{rand(1..9)}#{rand(1..9)}#{rand(1..9)}#{rand(1..9)}#{rand(1..9)}#{rand(1..9)}#{rand(1..9)}#{rand(1..9)}"
    new_surfboard.save
    url = SURF_URL.sample
    file = URI.open(url)
    new_surfboard.photo.attach(io: file, filename: 'surfboard.jpg', content_type: 'image/jpg')

    # for internal files
    # path = ActionController::Base.helpers.image_path('surfboard-seed/image6.jpg')
    # new_surfboard.photo.attach(io: File.open(path), filename: 'surfboard.jpg', content_type: 'image/jpg')
  puts "surfboard #{new_surfboard.id} created!"
  end

puts "user #{new_user.id} created!"

end


puts 'Creating bookings'
10.times do
  surf_id = rand(Surfboard.first.id..Surfboard.last.id)
  surf_board = Surfboard.find(surf_id)
  time_amount = surf_board.price_duration
  amount = surf_board.price
  date_end = rand(7.days.from_now..20.days.from_now)
  date_start = rand(3.days.from_now..6.days.from_now)
  Booking.create!(
    surfboard_id: surf_id,
    user_id: (User.first.id..User.last.id).grep_v(surf_board.user_id).sample,
    start_date: date_start,
    end_date: date_end,
    total_price: (((date_end - date_start) / 86400) * amount).round(2)
  )
end

puts 'Finished!'

