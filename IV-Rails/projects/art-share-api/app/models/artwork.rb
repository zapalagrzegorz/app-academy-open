# frozen_string_literal: true

class Artwork < ApplicationRecord
  validates :title, :image_url, presence: true
  validates :image_url, uniqueness: true
  validates :title, uniqueness: { scope: :artist_id }
  # uniqueness: { scope: :artist_id }

  belongs_to :artist,
             foreign_key: :artist_id,
             class_name: 'User'

  has_many :artwork_shares,
           foreign_key: :artwork_id,
           class_name: 'ArtworkShare'

  # Add a through association shared_viewers on Artwork. Artwork#shared_viewers will return the set of users with whom an artwork has been shared.
  has_many :shared_viewers,
           through: :artwork_shares,
           source: :viewer
end
