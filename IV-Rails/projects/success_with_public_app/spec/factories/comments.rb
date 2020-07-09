# == Schema Information
#
# Table name: comments
#
#  id               :bigint           not null, primary key
#  content          :text             not null
#  user_id          :bigint
#  commentable_type :string
#  commentable_id   :bigint
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.sentence(word_count: 3) }
    association :author, factory: :user
    association :commentable, factory: :goal
  end
end
