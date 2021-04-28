# == Schema Information
#
# Table name: cheers
#
#  id         :bigint           not null, primary key
#  giver_id   :bigint           not null
#  goal_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :cheer do
    
  end
end
