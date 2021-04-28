# frozen_string_literal: true

module Commentable
  extend ActiveSupport::Concern

  included do
    has_many :toys, as: :toyable
  end

  # zwykłe metody są poza included
  # methods

  # Jigsaw Woman
  def receive_toy(name)
    toys.create(name: name)
  end
  # metody statyczne są w podmodule ClassMethods
  # module ClassMethods
  # end
end
