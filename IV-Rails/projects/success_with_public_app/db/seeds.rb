# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 5.times do
# end
require 'factory_bot_rails'
require 'faker'

FactoryBot.create(:user, email: 'test@gmail.com', password: '123456')
user = FactoryBot.create(:user)
user2 = FactoryBot.create(:user)

5.times do |_i|
  FactoryBot.create(:goal, user: user)
  FactoryBot.create(:goal, user: user2)
end

5.times do |i|
  FactoryBot.create(:comment, author: user, commentable: user2.goals.offset(i).first)
  FactoryBot.create(:comment, author: user2, commentable: user.goals.offset(i).first)
end

FactoryBot.create(:comment, author: user, commentable: user2)
FactoryBot.create(:comment, author: user2, commentable: user)
