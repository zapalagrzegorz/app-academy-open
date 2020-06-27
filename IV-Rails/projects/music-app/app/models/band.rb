class Band < ApplicationRecord

  validate :name, presence: true
  
end
