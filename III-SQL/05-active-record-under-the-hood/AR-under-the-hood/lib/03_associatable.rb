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
  #   Phase IIIb: belongs_to, has_many

  # Begin writing a belongs_to method for Associatable. This method should take in the association name and an options hash. It should build a BelongsToOptions object; save this in a local variable named options.

  # Within belongs_to, call define_method to create a new method to access the association. Within this method:

  #     Use send to get the value of the foreign key.
  #     Use model_class to get the target model class.
  #     Use where to select those models where the primary_key column is equal to the foreign key value.
  #     Call first (since there should be only one such item).

  # Throughout this method definition, use the options object so that defaults are used appropriately.
  def belongs_to(name, options = {})
    # define_method to create a new method to access the association
    options = BelongsToOptions.new(name, options)

    define_method(name) do
      # options.foreign_key - nazwa kolumny
      # send(foreign_key) - wartość

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

  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
  end
end

class SQLObject
  # Mixin Associatable here...
  extend Associatable
end
