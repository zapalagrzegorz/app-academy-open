require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    # ...
    # After you have these basic defaults working, write #model_class, which should use String#constantize to go from a class name to the class object.
    class_name.constantize
  end

  def table_name
    # ...
    class_name.downcase.underscore + 's'
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    @foreign_key = options[:foreign_key] || (name.to_s.underscore + "_id").to_sym
    @primary_key = options[:primary_key] || :id
    @class_name = options[:class_name] || name.camelcase


  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    @primary_key = options[:primary_key] || :id
    @foreign_key = options[:foreign_key] || (self_class_name.singularize.underscore + "_id").to_sym
    @class_name = options[:class_name] || name.singularize.camelcase

  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    # ...
  end

  def has_many(name, options = {})
    # ...
  end

  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
  end
end

class SQLObject
  # Mixin Associatable here...
end
