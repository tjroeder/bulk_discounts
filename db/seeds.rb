# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
discount_1 = Discount.create(threshold: 8, percent: 10, merchant_id: 1)
discount_2 = Discount.create(threshold: 10, percent: 10, merchant_id: 1)
discount_3 = Discount.create(threshold: 3, percent: 15, merchant_id: 1)