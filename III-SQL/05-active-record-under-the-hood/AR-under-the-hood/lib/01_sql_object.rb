# frozen_string_literal: true

require_relative 'db_connection'
require 'active_support/inflector'
require 'byebug'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  # set columns name from table
  def self.columns
    return @columns if @columns

    raw_sql_results = DBConnection.execute2(<<-SQL)
      SELECT *
      FROM #{table_name}
    SQL

    @columns = raw_sql_results[0].map(&:to_sym)
  end

  # create getter / setter
  def self.finalize!
    columns.each do |column|
      define_method(column) do
        attributes[column]
      end

      define_method("#{column}=") do |val|
        attributes[column] = val
      end
    end
  end

  # getter/setter for table name from class name
  def self.table_name=(table_name)
    # class instance variable
    @custom_table = table_name
  end

  def self.table_name
    return name.tableize unless @custom_table

    @custom_table
    # self.name.underscore.pluralize
  end

  def self.all
    raw_sql_objects = DBConnection.execute(<<-SQL)
      SELECT *
      FROM "#{table_name}"
    SQL

    parse_all(raw_sql_objects)
  end

  def self.parse_all(results)
    results.map { |obj_hash| new(obj_hash) }
  end

  def self.find(id)
    sql_obj = DBConnection.execute(<<-SQL, id)
      SELECT *
      FROM #{table_name}
      WHERE id = ?
      LIMIT 1
    SQL
    new(sql_obj.first) if sql_obj.first
  end

  # Your #initialize method should iterate through each of the attr_name, value pairs.
  # For each attr_name, it should first convert the name to a symbol, and then check whether the attr_name is among the columns. If it is not, raise an error:
  # unknown attribute '#{attr_name}'
  # Set the attribute by calling the setter method. Use #send; avoid using @attributes or #attributes inside #initialize.
  # Hint: we need to call ::columns on a class object, not the instance. For example, we can call Dog::columns but not dog.columns.
  def initialize(params = {})
    params.each do |attr_name, value|
      column = attr_name.to_sym
      # p self.class.columns
      unless self.class.columns.include?(column)
        raise "unknown attribute '#{column}'"
      end

      send("#{column}=", value)
    end
  end

  # Remember that ActiveRecord::Base gives us a handy method #attributes
  # that hands us a hash of all our model's columns and values.
  # Let's define #attributes in SQLObject. It should lazily initialize @attributes
  def attributes
    @attributes ||= {}
  end

  # wrote a SQLObject#attribute_values method that returns an array of the values for each attribute. I did this by calling Array#map on SQLObject::columns, calling send on the instance to get the value.
  def attribute_values
    attribute_values = []

    attributes.map do |_value, col_value|
      attribute_values << col_value
    end

    attribute_values
  end

  #   To simplify building this query, I made two local variables:

  #     col_names: I took the array of ::columns of the class and joined it with commas.
  #     question_marks: I built an array of question marks (["?"] * n) and joined it with commas. What determines the number of question marks?

  # Lastly, when you call DBConnection.execute, you'll need to pass in the values of the columns. Two hints:

  #     I wrote a SQLObject#attribute_values method that returns an array of the values for each attribute. I did this by calling Array#map on SQLObject::columns, calling send on the instance to get the value.
  #     Once you have the #attribute_values method working, I passed this into DBConnection.execute using the splat operator.

  # When the DB inserts the record, it will assign the record an ID. After the INSERT query is run, we want to update our SQLObject instance with the assigned ID. Check out the DBConnection file for a helpful method.
  def insert
    columns = self.class.columns.drop(1)
    col_names = columns.map(&:to_s).join(', ')

    question_marks = (['?'] * columns.length).join(', ')
    table_name = self.class.table_name
    
    DBConnection.execute(<<-SQL, *attribute_values)
      INSERT INTO "#{table_name}" (#{col_names})
      VALUES (#{question_marks})
    SQL

    self.id = DBConnection.last_insert_row_id
  end

  def update
    columns = self.class.columns.drop(1)
    
    set_line = columns.map(&:to_s).join(' = ?, ') + ' = ?'

    # set_line = self.class.columns
    # .map { |attr| "#{attr} = ?" }.join(", ")
    
    DBConnection.execute(<<-SQL, *attribute_values.drop(1))

      UPDATE
        #{self.class.table_name}
      SET
        #{set_line}
      WHERE
        id = #{self.id}
    SQL
  end

  # This should call #insert or #update depending on whether id.nil?. 
  # It is not intended that the user call #insert or #update directly 
  # (leave them public so the specs can call them :-)).
  def save
    id.nil? ? insert : update

  end
end
