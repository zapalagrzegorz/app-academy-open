# frozen_string_literal: true

require 'active_support/inflector'

class ModelBase
  def self.table
    to_s.tableize
  end

  def self.find_by_id(id)
    item = QuestionsDatabase.instance.get_first_row(<<-SQL, id)
      SELECT *
      FROM #{table}
      WHERE id = ?
    SQL

    return nil if item.nil?

    new(item)
  end

  # Allow where to also accept a string fragment. The string fragment will be used to directly define the 'WHERE' statement in the SQL query:

  # User.where("lname = 'Stark'")
  # Question.where("title LIKE '%Who%' AND title LIKE '%Arstan Whitebeard%'")
  def self.where(params)
    if params.is_a?(Hash)
      where_line = params.keys.map { |key| "#{key} = ?" }.join(' AND ')
      vals = params.values
    else
      where_line = params
      vals = []
    end
    queryObjects = QuestionsDatabase.execute(<<-SQL, *vals)
      SELECT
        *
      FROM
        #{table}
      WHERE
        #{where_line}
    SQL

    queryObjects.map { |queryObj| new(queryObj) }
  end

  # Implement a flexible find_by which allows users to find records with any number of arguments. Let's see an example:
  def find_by(params)
    where(params)
  end

  def self.parse_all(data)
    data.map { |attrs| new(attrs) }
  end
end
