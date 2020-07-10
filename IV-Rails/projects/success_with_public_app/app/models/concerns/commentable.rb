# frozen_string_literal: true

module Commentable
  extend ActiveSupport::Concern

  included do
    has_many :comments, as: :commentable
  end

  # zwykłe metody są poza included
  # methods

  # metody statyczne są w podmodule ClassMethods
  # module ClassMethods
  # end
end
