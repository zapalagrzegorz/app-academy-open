# frozen_string_literal: true

class Artwork < ApplicationRecord
  validates :title, :image_url, presence: true
  validates :image_url, uniqueness: true
  # unikalny tylko dla danego user'a - każdy z userów może mieć tytuł "undefinded"
  validates :title, uniqueness: { scope: :artist_id }
  # uniqueness: { scope: :artist_id }

  belongs_to :artist,
             foreign_key: :artist_id,
             class_name: 'User'

  # udostępnienia pracy
  has_many :artwork_shares,
           foreign_key: :artwork_id,
           class_name: 'ArtworkShare'

  # Artwork#shared_viewers will return the set of users with whom an artwork has been shared.
  has_many :shared_viewers,
           through: :artwork_shares,
           source: :viewer

  has_many :comments,
           dependent: :destroy

  has_many :likes, as: :likeable
          #  dependent: :destroy

          # is possible?
  has_many :liking_users,
           through: :likes,
           source: :user

           
  #          source_type: 'User'
  # def artworks_for_user(user_id)
  #   Artwork.left_outer_joins(:artwork_shares).where('(artworks.artist_id == ? OR artwork_shares.viewer_id == ?)', user_id)
  # end
  def self.artworks_for_user_id(user_id)
    Artwork
      .left_outer_joins(:artwork_shares)
      .where('(artworks.artist_id = :user_id) OR (artwork_shares.viewer_id = :user_id)', user_id: user_id)
    # .distinct
  end
end
