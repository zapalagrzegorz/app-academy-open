# frozen_string_literal: true

# == Schema Information
#
# Table name: goals
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  details    :text
#  completed  :boolean          default(FALSE)
#  private    :boolean          default(FALSE)
#  user_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :goal do
    title { Faker::Lorem.sentence(word_count: 3) }
    details { Faker::Lorem.sentence(word_count: 5) }
    association :user, factory: :user
  end
end
