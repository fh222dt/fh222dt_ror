# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = User.create (
    [
        {email: 'dev@test.se', password: 'hejhej', password_confirmation: 'hejhej'},
        {email: 'nisse@test.se', password: 'hejhej', password_confirmation: 'hejhej'},
        {email: 'frida@test.se', password: 'hejhej', password_confirmation: 'hejhej'},
        {email: 'admin@test.se', password: 'hejhej', password_confirmation: 'hejhej', isAdmin: true}
    ]
)

api_keys = Key.create (
    [   
        {key: SecureRandom.urlsafe_base64, application_name: 'Turist Nord', url: 'www.turistnord.se', user_id: 1},
        {key: SecureRandom.urlsafe_base64, application_name: 'Västkusten', url: 'www.vastkusten.se', user_id: 1},
        {key: SecureRandom.urlsafe_base64, application_name: 'Visit Gränna', url: 'www.polkagrisar.se', user_id: 2},
        {key: SecureRandom.urlsafe_base64, application_name: 'Gränna Stad', url: 'www.granna.se', user_id: 2},
        {key: SecureRandom.urlsafe_base64, application_name: 'Upplands Bro Kommun', url: 'www.upplandsbro.se', user_id: 3},
        {key: SecureRandom.urlsafe_base64, application_name: 'Mälardalsleden', url: 'www.malardalsleden.se', user_id: 3},
        {key: '4THfq1zw8fYklpaqZW4MKA', application_name: 'Postman app', url: 'www.postman.se', user_id: 3},
        
    ]    
)

100.times do |n|
  app_name  = Faker::Company.name
  url = Faker::Internet.url
  user = Faker::Number.between(1, 3)
  
  Key.create!( key:                 SecureRandom.urlsafe_base64,
               application_name:    app_name,
               url:                 url,
               user_id:             user)
end

#Seed tags
tag1 = Tag.create(name: 'Barnvänligt')
tag2 = Tag.create(name: 'Vacker utsikt')
tag3 = Tag.create(name: 'Romantiskt')
tag4 = Tag.create(name: 'Naturmiljö')
tag5 = Tag.create(name: 'Stadsmiljö')
tag6 = Tag.create(name: 'Handikappanpassat')
    

#Seed picknick places
35.times do |n|
  user  = Faker::Number.between(1, 3)
  long = Faker::Address.longitude
  lat = Faker::Address.latitude
  city = Faker::Address.city
  desc = Faker::Lorem.sentences(1)
  
 picknick = Place.create!(user_id: user,
                longitude: long,
                latitude: lat,
                city: city,
                description: desc)
 
 picknick.tags << tag2
 
 # picknick.tags.create(
 #    place_id: Faker::Number.between(1, 10),
 #   tag_id: Faker::Number.between(1, 6))
    
end

#Seed comments
20.times do |n|
  user  = Faker::Number.between(1, 3)
  place = Faker::Number.between(1, 10)
  desc = Faker::Lorem.paragraph
  
  Comment.create!(user_id: user,
                place_id: place,
                text: desc)
end