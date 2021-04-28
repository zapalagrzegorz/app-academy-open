# frozen_string_literal: true

module Toyable
  extend ActiveSupport::Concern

  included do
    has_many :toys, class_name: 'Toy', as: :toyable
  end

  # Jigsaw Woman

  # Next write a # receive_toy(name) method. Any animal instance whose class includes the Toyable concern can call this method.

  # This method should first find or create a toy whose name matches the argument.

  # Next it should add this toy to self's toys.

  # For both steps, you may wish to use the ActiveRecord #find_or_create_by method.
  def receive_toy(name)
    # This method always returns a record, but if creation was attempted and failed due to validation errors it won't be persisted, you get what create returns in such situation.
    toy = Toy.find_or_create_by(name: name)
    # toy nie jest zapisywany, bo nie przechodzi walidacji w aspekcie belongs_to, do jakiegoś właściciela
    # metoda tylko zwraca obiekt
    toys.find_or_create_by(name: toy.name)
    #  self.toys.find_or_create_by(name: name)
  end
end
