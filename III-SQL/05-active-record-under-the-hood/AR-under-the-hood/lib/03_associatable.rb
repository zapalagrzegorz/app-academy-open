# frozen_string_literal: true

require_relative '02_searchable'
require 'active_support/inflector'
require 'byebug'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :primary_key,
    :class_name
  )

  def model_class
    class_name.constantize
  end

  def table_name
    class_name.downcase.underscore + 's'
    # model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    @foreign_key = options[:foreign_key] || (name.to_s.underscore + '_id').to_sym
    @primary_key = options[:primary_key] || :id
    @class_name = options[:class_name] || name.to_s.camelcase
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    @primary_key = options[:primary_key] || :id
    @foreign_key = options[:foreign_key] || (self_class_name.to_s.singularize.underscore + '_id').to_sym

    @class_name = options[:class_name] || name.to_s.singularize.camelcase
  end
end

module Associatable
  # Begin writing a belongs_to method for Associatable. This method should take in the association
  # name and an options hash.
  # It should build a BelongsToOptions object;

  def belongs_to(name, options = {})
    # zobacz #assoc_options
    assoc_options[name] = BelongsToOptions.new(name, options)
    define_method(name) do
      # options.foreign_key - nazwa kolumny
      # send(foreign_key) - wartość

      options = self.class.assoc_options[name]
      foreign_key_value = send(options.foreign_key)

      where_line = { "#{options.primary_key}": foreign_key_value }

      options.model_class.where(where_line).first
    end
  end

  def has_many(name, options = {})
    options = HasManyOptions.new(name, self, options)

    define_method(name) do
      primary_key_value = send(options.primary_key)

      where_line = { "#{options.foreign_key}": primary_key_value }

      options.model_class.where(where_line)
    end

    # debugger
  end

  # extend Associatable powoduje, że metody będą dopisane do klasy
  # to jest metoda statyczna/ ::class_method
  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
    # lazy initialized
    #  @assoc_options  to class variable - zmienna zapisana na obiekcie tej Klasy
    # zapisana w klasie pozwala na zapisanie w stanie klasy wszystkich informacji
    # o dotychczasowych powiazaniach

    @assoc_options ||= {}
  end
end

class SQLObject
  # Mixin Associatable here...
  extend Associatable
end
