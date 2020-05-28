class Comment < ApplicationRecord
  validates :body, presence: true
  
  belongs_to :user

  belongs_to :artwork

  has_many :likes, as: :likeable

  has_many :liking_users,
    through: :likes,
    source: :likeable,
    source_type: 'User'
    

end
