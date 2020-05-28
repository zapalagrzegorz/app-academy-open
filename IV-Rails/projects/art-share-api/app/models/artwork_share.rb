# frozen_string_literal: true

class ArtworkShare < ApplicationRecord
  # Ensure that a user cannot have a single Artwork shared with them more than once.
  validates :artwork_id, uniqueness: { scope: :viewer_id }
  #   validates :artwork_id, uniqueness: { scope: :viewer_id }
  
  # nie walidować obecności klucza obcego
  # validates :artwork_id, :viewer_id, presence: true

  belongs_to :viewer,
             foreign_key: 'viewer_id',
             class_name: 'User'

  belongs_to :artwork
  
  # class method that returns all of the artworks made by the user OR
  # shared with the user
  
  # available_artworks += artworks
  # available_artworks + shared_artworks
  # def self.user_favourites(user_id)
  #   ArtworkShare
  #     .joins('JOIN artworks ON artwork_shares.artwork_id = artworks.id')
  #     .where(viewer_id: user_id).where(favourite: true)
  # end
end
