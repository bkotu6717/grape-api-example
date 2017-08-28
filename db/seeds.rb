# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Graduate.destroy_all
graduates = []
100.times { |i| graduates << { name: "Graduate #{i + 1}"} }
Graduate.create! graduates

User.destroy_all
User.create email: 'sampleuser@test.com', password: '12345', password_confirmation: '12345'