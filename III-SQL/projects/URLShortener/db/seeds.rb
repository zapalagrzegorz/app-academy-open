# frozen_string_literal: true

# # frozen_string_literal: true

# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# #   Character.create(name: 'Luke', movie: movies.first)

# # zero filozofia - tak jak intuicja podpowiada
# # ale najpierw musisz mieć obiekt shortened_url, aby stworzyć obiekt Otagowania

u1 = User.create!(email: 'gz@gmail.com', premium: true)
u2 = User.create!(email: 'gz2@gmail.com')
u3 = User.create!(email: 'gz3@gmail.com')

# u1.premium = true
# u1.save!

su1 = ShortenedUrl.create_for_user_and_long_url!(
  u1, 'www.google.com'
)
su2 = ShortenedUrl.create_for_user_and_long_url!(
  u2, 'gmail.com'
)

su3 = ShortenedUrl.create_for_user_and_long_url!(
  u3, 'netpr.pl'
)
su4 = ShortenedUrl.create_for_user_and_long_url!(
  u1, 'classroom.google.pl'
)

Visit.record_visit!(user: su1, shortened_url: su1)
Visit.record_visit!(user: su2, shortened_url: su1)
Visit.record_visit!(user: su3, shortened_url: su1)
Visit.record_visit!(user: su1, shortened_url: su2)
Visit.record_visit!(user: su2, shortened_url: su2)
Visit.record_visit!(user: su1, shortened_url: su3)
Visit.record_visit!(user: su2, shortened_url: su3)
Visit.record_visit!(user: su3, shortened_url: su3)

tag_topic1 = TagTopic.create!(title: 'tools')
tag_topic2 = TagTopic.create!(title: 'work')

Tagging.create!(shortened_url: su1, tag_topic: tag_topic1)
Tagging.create!(shortened_url: su2, tag_topic: tag_topic1)
Tagging.create!(shortened_url: su3, tag_topic: tag_topic2)
Tagging.create!(shortened_url: su4, tag_topic: tag_topic1)
