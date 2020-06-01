# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Cat.destroy_all

Cat.create(birth_date: '2020/04/30', color: 'blue', name: "Rex", sex: "M", description: "Cute, but aggresive")
Cat.create(birth_date: '2020/03/22', color: 'green', name: "Hellena", sex: "F", description: "Quite ok")
Cat.create(birth_date: '2020/02/20', color: 'yellow', name: "Kocys", sex: "M", description: "Long story...")