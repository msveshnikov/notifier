# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# 3.times do |i|
#   User.create(name: "User ##{i}", email: "test@example.com")
# end

#Site.create(url: "http://microsoft.com", user_id: 1, hash_content: 783473498)

Category.create(name: "Entertainment", color: "#BE1E4E")
Category.create(name: "Business", color: "#184DC1")
Category.create(name: "Sport", color: "#7CFC00")
Category.create(name: "Music", color: "#FA3E32")
Category.create(name: "Video", color: "#932667")