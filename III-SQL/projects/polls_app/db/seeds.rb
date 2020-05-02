# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Problem z istniejącymi danymi?
# Należy je usunąć
Response.destroy_all
AnswerChoice.destroy_all
Question.destroy_all
Poll.destroy_all
User.destroy_all

# user
# 10.times do
gz = User.create!(username: 'gelozapala')
us2 = User.create!(username: 'Marcin Kowalewski')

us3 = User.create!(username: 'User3')
us4 = User.create!(username: 'User4')
us5 = User.create!(username: 'User5')
us6 = User.create!(username: 'User6')
us7 = User.create!(username: 'User7')
us8 = User.create!(username: 'User8')
us9 = User.create!(username: 'User9')
# end

poll1 = Poll.create!(title: "Intimate preferences#{rand(1000)}", user_id: gz.id)

poll2 = Poll.create!(title: "Intimate preferences#{rand(1000)}", user_id: us2.id)

question1 = Question.create!(text: 'Do you like girls?', poll_id: poll1.id)

ac1 = AnswerChoice.create!(text: 'yes', question_id: question1.id)
ac2 = AnswerChoice.create!(text: 'no',  question_id: question1.id)
ac3 = AnswerChoice.create!(text: 'maybe', question_id: question1.id)
ac4 = AnswerChoice.create!(text: 'refuse to answer', question_id: question1.id)

#  id               :bigint           not null, primary key
#  user_id          :bigint
#  answer_choice_id :bigint

response1 = Response.create!(user_id: us2.id, answer_choice_id: ac1.id)
response2 = Response.create!(user_id: us3.id, answer_choice_id: ac1.id)
response3 = Response.create!(user_id: us4.id, answer_choice_id: ac1.id)

response4 = Response.create!(user_id: us5.id, answer_choice_id: ac2.id)
response5 = Response.create!(user_id: us6.id, answer_choice_id: ac2.id)

response6 = Response.create!(user_id: us7.id, answer_choice_id: ac3.id)
# response7 = Response.create!(user_id: us8.id, answer_choice_id: ac4.id)
