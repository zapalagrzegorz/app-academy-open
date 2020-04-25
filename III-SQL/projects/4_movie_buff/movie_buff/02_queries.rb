# frozen_string_literal: true

# == Schema Information
#
# Table name: actors
#
#  id          :integer      not null, primary key
#  name        :string
#
# Table name: movies
#
#  id          :integer      not null, primary key
#  title       :string
#  yr          :integer
#  score       :float
#  votes       :integer
#  director_id :integer
#
# Table name: castings
#
#  id          :integer      not null, primary key
#  movie_id    :integer      not null
#  actor_id    :integer      not null
#  ord         :integer

def eighties_b_movies
  # List all the movies from 1980-1989 with scores falling between
  # 3 and 5 (inclusive).
  # Show the id, title, year, and score.
  Movie.select(:id, :title, :yr, :score).where(score: 3..5, yr: 1980..1989)
end

def bad_years
  # List the years in which a movie with a rating above 8 was not released.
  # good_years = Movie.select(:yr).distinct.where('score > 8 ').pluck(:yr)
  Movie.select(:yr).distinct.where('yr NOT IN (SELECT DISTINCT movies.yr FROM movies WHERE score > 8)').pluck(:yr)

  # solution:
  # Movie.group(:yr).having('MAX(score) < 8').pluck(:yr)
end

def cast_list(title)
  # List all the actors for a particular movie, given the title.
  # Sort the results by starring order (ord). Show the actor id and name.
  Actor.select(:id, :name).joins(:movies).where(movies: { title: title }).order(ord: :asc)
end

def vanity_projects
  # List the title of all movies in which the director also appeared
  # as the starring actor.
  # Show the movie id and title and director's name.

  # Note: Directors appear in the 'actors' table.
  Movie.select('movies.id, movies.title, actors.name').joins(:actors).where('movies.director_id = actors.id AND castings.ord = 1')
  # .where('movies.id = actors.director_id')
  # 1 nie wszystkie pola z zadania
  # 2 błedna nazwa pola w tabeli
  # 3 błędne odczytanie referencji belongs to - foreign_id jest w tabeli, która jest belongs_tos
end

def most_supportive
  # Find the two actors with the largest number of non-starring roles.
  # Show each actor's id, name and number of supporting roles.

  Actor.select(:id, :name, 'COUNT(actors.id) AS roles').joins(:castings).where.not(castings: { ord: 1 }).group('actors.id').order('COUNT(actors.id) DESC').limit(2)
  #  .where.not(castings: { ord: 1 })
  # .select(:id, :name, 'COUNT(castings.actor_id) as roles')

  # Actor
  #   .select(:id, :name, 'COUNT(castings.actor_id) as roles')
  #   .joins(:castings)
  #   .where.not(castings: { ord: 1 })
  #   .group('actors.id')
  #   .order('roles DESC')
  #   .limit(2)
end
