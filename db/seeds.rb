# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
3.times do |i|
  User.create(name: "User ##{i}", email: "test@example.com")
end

Site.create(url: "http://microsoft.com", user_id: 1, hash_content: 783473498)
