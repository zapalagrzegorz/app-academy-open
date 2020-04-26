# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# user
5.times do
  User.create!(username: "gelozapala#{rand(1000)}")
end

poll1 = Poll.create!(title: "Intimate preferences#{rand(1000)}", user_id: 1)

question1 = Question.create!(text: 'Do you like girls?', poll_id: Poll.first.id)

# ac1 = AnswerChoice.create!(text: 'yes')
# ac2 = AnswerChoice.create!(text: 'no')
# ac3 = AnswerChoice.create!(text: 'maybe')
# ac4 = AnswerChoice.create!(text: 'refuse to answer')

# response1 = Response.create!(user_id: 2, answer_choice_id: ac2.id)
# response2
# response3
# response4
# Poll.create!
