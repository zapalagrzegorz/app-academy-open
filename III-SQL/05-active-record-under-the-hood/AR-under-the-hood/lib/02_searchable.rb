# frozen_string_literal: true

require_relative 'db_connection'
require_relative '01_sql_object'
require 'byebug'

module Searchable
  def where(params)
    # where_line = []
    # params.each do |k, v|
    #   where_line << "#{k} = ?"
    # end

    where_line = params.keys.map { |key| "#{key} = ?" }.join(' AND ')

    sql_result = DBConnection.execute(<<-SQL, *params.values)
      SELECT *
      FROM #{table_name}
      WHERE #{where_line}
    SQL

    parse_all(sql_result)
  end
end

class SQLObject
  # add as a class method
  extend Searchable
end
