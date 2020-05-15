# frozen_string_literal: true

require_relative '03_associatable'

# Phase IV
module Associatable
  # Remember to go back to 04_associatable to write ::assoc_options

  def has_one_through(name, through_name, source_name)
    # ...
    # has_one_through :home, :human, :house

    define_method(name) do
      # pobierz obiekt pośredniczący, a potem jego obiekt powiązany
      # tak dwa selekty
      send(through_name).send(source_name)
      # # through_name = self.class.assoc_options[through_name]
      # # target_name = self.class.assoc_options[source_name]
      # through_obj = send(through_name)

      # through_obj.send(source_name)
    end

  end
end
