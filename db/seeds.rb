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