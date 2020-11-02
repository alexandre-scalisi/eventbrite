require 'faker'
Faker::Config.locale = :fr

10.times do 
  User.create(email: Faker::Name.unique.name+"@yopmail.com", first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::Lorem.sentence)
end

10.times do
  Event.create(start_date: Faker::Date.forward(days: 365),duration: (1..100000).to_a.select{|i| i%2==0}.sample, title: Faker::Superhero.name, price: rand(1..15000), administrator: User.all.sample,location: Faker::Games::Zelda.location)
end

10.times do
  Attendance.create(strip_customer_id: Faker::Name.unique.name, user: User.all.sample, event: Event.all.sample)
end