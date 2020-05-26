# frozen_string_literal: true

class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true

  has_many :artworks,
           foreign_key: :artist_id,
           dependent: :destroy

#  User#shared_artworks will return the set of artworks that have been shared with that user (not the set of artworks that a user has shared with others).
  has_many :shared_artworks,
          through: :artwork_shares,
          source: :artworks
end
