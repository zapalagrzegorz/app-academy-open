# frozen_string_literal: true

require_relative '03_associatable'

# Phase IV
module Associatable
  # Remember to go back to 04_associatable to write ::assoc_options

  def has_one_through(name, _through_name, _source_name)
    # ...
    # has_one_through :home, :human, :house

    # SELECT
    # houses.*
    # FROM
    #   humans
    # JOIN
    #   houses ON humans.house_id = houses.id
    # WHERE
    #   humans.id = ?
    # source_name -> model_class
    # define_method(name) do |_through_name, _source_name|
    # BelongsToOptions.class_name - human
    # human.call_method(source_name.to_s.camelcase)

    # cat.human.house

    # self.[through_name].[source_name]
    # end
  end
end
