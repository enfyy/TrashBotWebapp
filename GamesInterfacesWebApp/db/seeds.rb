# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
cat1 = Category.create!(name: "Bioabfall")
cat2 = Category.create!(name: "Restmüll")
cat3 = Category.create!(name: "Papier/Pappe/Karton")
cat4 = Category.create!(name: "Behälterglas")
cat5 = Category.create!(name: "Leichtverpackungen")
cat6 = Category.create!(name: "Pfand")
cat7 = Category.create!(name: "Sonstiges", non_trash: true)
cat8 = Category.create!(name: "Kein Müll", non_trash: true)