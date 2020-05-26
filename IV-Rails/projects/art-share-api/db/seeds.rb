# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Artwork.destroy_all
ArtworkShare.destroy_all

gz = User.create!(username: 'gelozapala')
us2 = User.create!(username: 'Marcin Kowalewski')

8.times do |number|
  User.create!(username: "User#{number + 3}")
end

aw1 = Artwork.create!(title: 'Sloneczniki van gogha', image_url: 'sloneczniki.com', artist_id: gz.id)
aw2 = Artwork.create!(title: 'Guerilla', image_url: 'guerilla.pl', artist_id: gz.id)
aw3 = Artwork.create!(title: 'Bitwa pod Grunwaldem', image_url: 'Grunwald.pl', artist_id: gz.id)

aw4 = Artwork.create!(title: 'Karmienie', image_url: 'karmienie.com.pl', artist_id: us2.id)
aw5 = Artwork.create!(title: 'Moce teatru', image_url: 'teatr.com.pl', artist_id: us2.id)

ArtworkShare.create!(artwork_id: aw1.id, viewer_id: us2.id)
ArtworkShare.create!(artwork_id: aw2.id, viewer_id: us2.id)
ArtworkShare.create!(artwork_id: aw3.id, viewer_id: us2.id)

ArtworkShare.create!(artwork_id: aw4.id, viewer_id: gz.id)
ArtworkShare.create!(artwork_id: aw5.id, viewer_id: gz.id)
