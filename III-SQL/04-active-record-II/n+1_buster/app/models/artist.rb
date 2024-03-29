# frozen_string_literal: true

# == Schema Information
#
# Table name: artists
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Artist < ApplicationRecord
  has_many :albums,
           class_name: 'Album',
           foreign_key: :artist_id,
           primary_key: :id

  def n_plus_one_tracks
    albums = self.albums
    tracks_count = {}
    albums.each do |album|
      tracks_count[album.title] = album.tracks.length
    end

    tracks_count
  end

  def better_tracks_query
    # TODO: your code here
    albums = self.albums
                 .select('albums.*, COUNT(*) as album_track_length')
                 .joins(:tracks)
                 .group('albums.id')
    tracks_count = {}
    albums.each do |album|
      tracks_count[album.title] = album.album_track_length
    end

    tracks_count
  end
end
