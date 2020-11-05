require 'faker'

Faker::Config.locale = :fr

User.destroy_all
Event.destroy_all
Attendance.destroy_all
1.times do 
  
  user = User.create(email: Faker::Name.unique.name.gsub(/\s+/, "")+"@yopmail.com", first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::Lorem.sentence,password:"testpw")
  user.photo.attach(io: File.open(ActionController::Base.helpers.asset_path('download.jpeg')), filename: 'download.jpeg')

end

1.times do
  event = Event.create(start_date: Faker::Date.forward(days: 365),duration: (1..100000).to_a.select{|i| i%5==0}.sample, title: Faker::Superhero.name, price: rand(1..1000), administrator: User.all.sample,location: Faker::Games::Zelda.location, description: Faker::Lorem.sentence)
  event.photo.attach(io: File.open(ActionController::Base.helpers.asset_path('download.jpeg')), filename: 'download.jpeg')
end

1.times do
  Attendance.create(strip_customer_id: Faker::Name.unique.name, user: User.all.sample, event: Event.all.sample)
end