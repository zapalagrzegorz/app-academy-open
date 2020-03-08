# frozen_string_literal: true

require 'sqlite3'
require 'singleton'

class PlayDBConnection < SQLite3::Database
  include Singleton

  def initialize
    super('plays.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Play
  attr_accessor :id, :title, :year, :playwright_id

  def self.all
    data = PlayDBConnection.instance.execute('SELECT * FROM plays')
    data.map { |datum| Play.new(datum) }
  end

  # Play::find_by_title(title)
  def self.find_by_title(title)
    play = PlayDBConnection.instance.execute(<<-SQL, title)
      SELECT *
      FROM plays
      WHERE title = ?
    SQL

    Play.new(play.first) if play.first
  end

  # Play::find_by_playwright(name)
  def self.find_by_playwright(name)
    # wypadało zapytać czy taki pisarz jest w bazie
    #  playwright = Playwright.find_by_name(name)
    # raise "#{name} not found in DB" unless playwright
    plays = PlayDBConnection.instance.execute(<<-SQL, name)
      SELECT *
      FROM plays
      JOIN playwrights ON playwright_id = playwrights.id
      WHERE playwrights.name = ?
    SQL

    plays.map { |play| Play.new(play) }
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @year = options['year']
    @playwright_id = options['playwright_id']
  end

  def create
    raise "#{self} already in database" if id

    PlayDBConnection.instance.execute(<<-SQL, title, year, playwright_id)
      INSERT INTO
        plays (title, year, playwright_id)
      VALUES
        (?, ?, ?)
    SQL
    self.id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless id

    PlayDBConnection.instance.execute(<<-SQL, title, year, playwright_id, id)
      UPDATE
        plays
      SET
        title = ?, year = ?, playwright_id = ?
      WHERE
        id = ?
    SQL
  end
end

# In addition, create a Playwright class and add the following methods to our ORM.

# Playwright::all
# Playwright::find_by_name(name)
# Playwright#new (this is the initialize method)
# Playwright#create
# Playwright#update
# Playwright#get_plays (returns all plays written by playwright)
class Playwright
  attr_accessor :birth_year
  # attr_reader :id
  # Playwright::all
  def self.all
    playwrights = PlayDBConnection.instance.execute('SELECT * FROM playwrights')
    playwrights.map { |playwright| Playwright.new(playwright) }
  end

  # Playwright::find_by_name(name)
  def self.find_by_name(name)
    # SQL zwraca tablicę
    playwright = PlayDBConnection.instance.execute(<<-SQL, name)
      SELECT *
      FROM playwrights
      WHERE playwrights.name = ?
    SQL

    Playwright.new(playwright.first) if playwright.one?
  end

  def initialize(props)
    # p props
    @id = props['id']
    @name = props['name']
    @birth_year = props['birth_year']
  end

  # Playwright#create
  def create
    #   raise "#{self} already in database" if id
    raise "#{self} is already in database" if @id

    PlayDBConnection.instance.execute(<<-SQL, @name, @birth_year)
      INSERT INTO
        playwrights (name, birth_year)
      VALUES
        (?, ?)
    SQL
    # insert returns empty array
    @id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not yet id database" unless @id

    PlayDBConnection.instance.execute(<<-SQL, @name, @birth_year, @id)
      UPDATE
        playwrights
      SET
        name = ?, birth_year = ?
      WHERE
      id = ?
    SQL
  end

  def get_plays
    plays = PlayDBConnection.instance.execute(<<-SQL, @id)
        SELECT *
        FROM playwrights
        JOIN plays ON plays.playwright_id = playwrights.id
        WHERE playwrights.id = ?
    SQL

    plays.map { |play| Play.new(play) }
  end
end
