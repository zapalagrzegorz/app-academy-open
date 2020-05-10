require_relative 'db_connection'
require_relative '01_sql_object'
require 'byebug'

module Searchable
  def where(params)
    values = []
    where_line = []
    params.each do |k, v| 
      where_line << "#{k} = ?" 
      values << v
    end

    sql_result = DBConnection.execute(<<-SQL, values)
      SELECT *
      FROM #{table_name}
      WHERE #{where_line.join(' AND ')}
    SQL

    parse_all(sql_result)
  end
end

class SQLObject
  extend Searchable
end
