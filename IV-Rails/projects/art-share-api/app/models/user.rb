# frozen_string_literal: true

require_relative './artwork.rb'

class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true

  has_many :artworks,
           foreign_key: :artist_id,
           dependent: :destroy

  has_many :artwork_shares,
           foreign_key: :viewer_id,
           dependent: :destroy

  #  User#shared_artworks will return the set of artworks that have been shared with that user
  # (not the set of artworks that a user has shared with others).
  has_many :shared_artworks,
           through: :artwork_shares,
           source: :artwork

  has_many :comments,
           dependent: :destroy

  has_many :likes

  has_many :liked_comments,
    through: :likes,
    source: :likeable,
    source_type: 'Comment'
    
  has_many :liked_artworks,
    through: :likes,
    source: :likeable,
    source_type: 'Artwork'

    # has_many :liked_artworks,
    # through: :likes,
    # source: :likeable,
    # source_type: 'Artwork'

    
    # Let's also allow users to favorite artworks. T
    # this will require additional columns to artworks 
    # (for favoriting of artworks by their owner) and shared artworks 
    # (for favoriting of artworks shared to a user). 
    # Use a semantic custom route to accomplish this. Hint.


  def favorite_artworks
    artworks.where(favorite: true)
  end

  def favorite_shared_artworks
    shared_artworks.where('artwork_shares.favorite = true')
  end

  # all favourites
  def self.user_favourites(user_id)
    Artwork.artworks_for_user_id(user_id).where('artworks.favourite = true OR artwork_shares.favourite = true')
  end

end
