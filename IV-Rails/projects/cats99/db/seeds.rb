# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Cat.destroy_all
CatRentalRequest.destroy_all

user = User.create!(username: 'zapala.grzegorz', password: 'abcdef')
user2 = User.create!(username: 'admin', password: 'password')

cat1 = Cat.create!(birth_date: '2020/04/30', color: 'blue', name: 'Rex', sex: 'M', description: 'Cute, but aggresive', user_id: user2.id)
Cat.create!(birth_date: '2020/03/22', color: 'green', name: 'Hellena', sex: 'F', description: 'Quite ok', user_id: user.id)
Cat.create!(birth_date: '2020/02/20', color: 'yellow', name: 'Kocys', sex: 'M', description: 'Long story...', user_id: user2.id)

CatRentalRequest.create!(cat_id: cat1.id, start_date: '2020/02/25', end_date: '2020/02/27', user_id: user.id)
CatRentalRequest.create!(cat_id: cat1.id, start_date: '2020/02/27', end_date: '2020/02/28', user_id: user.id)
CatRentalRequest.create!(cat_id: cat1.id, start_date: '2020/02/24', end_date: '2020/02/25', user_id: user.id)
CatRentalRequest.create!(cat_id: cat1.id, start_date: '2020/02/22', end_date: '2020/02/23', user_id: user.id)
