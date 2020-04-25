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

def what_was_that_one_with(those_actors)
  # Find the movies starring all `those_actors` (an array of actor names).
  # Show each movie's title and id.

  Movie.select(:id, :title).joins(:actors).where(actors: { name: those_actors }).group(:id).having('COUNT(actors.id) >= ?', those_actors.length)
  # solution nie jest na to odpowiedzią, bo działa tylko jako logicznie OR przez użycie WHERE actors.name IN ...
end

def golden_age
  # Find the decade with the highest average movie score.
  # 1917 / 10 - 191
  # 1920 / 10 - 192 * 10 = 1920
  # Korzystając z możliwości grupowania, musimy być świadomi pewnej logicznej konsekwencji. We wszystkich kolejnych krokach przetwarzania zapytania następujących po klauzuli GROUP BY
  #  (czyli w HAVING, SELECT, ORDER BY), będziemy mogli bezpośrednio wybierać tylko dane z kolumn sekcji grupującej. Wszystkie pozostałe kolumny, zawarte w sekcji surowej, mogą być wyciągane i przetwarzane tylko za pośrednictwem funkcji agregujących.

  # .first zwraca obiekt .decade zwraca props
  Movie.select('AVG(score), (yr / 10) * 10 AS decade').group('decade').order('AVG(score) DESC').limit(1).first.decade
  # group
  # pluck
  # AVG(:score) AS avg_score
  # order(avg_score DESC)
  # limit(1)
end

def costars(name)
  # List the names of the actors that the named actor has ever
  # appeared with.
  # Hint: use a subquery
  subquery = Movie.select(:id).joins(:actors).where(actors: { name: name })

  Actor.select(:name).distinct.joins(:movies).where.not(name: name).where(movies: { id: subquery }).pluck(:name)
end

def actor_out_of_work
  # Find the number of actors in the database who have not appeared in a movie
  Actor.left_outer_joins(:movies).where(movies: { id: nil }).count
end

def starring(whazzername)
  # Find the movies with an actor who had a name like `whazzername`.
  # A name is like whazzername if the actor's name contains all of the
  # letters in whazzername, ignoring case, in order.

  # lester stone

  # Sylvester Stallone
  # lester stone

  # Syv all
  # one
  # st
  # ex. "Sylvester Stallone" is like "sylvester" and "lester stone" but
  # not like "stallone sylvester" or "zylvester ztallone"
  Movie.joins(:actors).where('actors.name LIKE ?', '%' + whazzername + '%')
  # Movie.joins(:actors).where("actors.name LIKE '%Stallone%'")

  # zamień 'word' na "w%o%r%d"
  matcher = "%#{whazzername.split(//).join('%')}%"

  # metoda UPPER dla kolumny oraz szukanej wartości pozwala na case-ignore
  Movie.joins(:actors).where('UPPER(actors.name) LIKE UPPER(?)', matcher)
end

def longest_career
  # Find the 3 actors who had the longest careers
  # (the greatest time between first and last movie).
  # Order by actor names. Show each actor's id, name, and the length of
  # their career.
  Actor.select(:id, :name, 'MAX(movies.yr) - MIN(movies.yr) AS career').joins(:movies).order('career DESC, name').group(:id).limit(3)
      #  .order('career DESC, name')
  # group(  )
  # .select(:name, :id, 'MAX(movies.yr) - MIN(movies.yr) AS career')

    # Actor
    # .select(:name, :id, 'MAX(movies.yr) - MIN(movies.yr) AS career')
    # .joins(:movies)
    # .order('career DESC, name')
    # .group(:id)
    # .limit(3)
end
