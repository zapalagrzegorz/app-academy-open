# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do
  todo = Todo.create(title: Faker::Hipster.sentence(word_count: 3), body: Faker::Marketing.buzzwords)
  2.times do
    todo.steps.create(title: Faker::Hipster.sentence)
    todo.tags.create(name: Faker::Company.buzzword)
  end
end
