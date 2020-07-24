# == Schema Information
#
# Table name: comments
#
#  id                :bigint           not null, primary key
#  content           :text
#  author_id         :bigint
#  post_id           :bigint
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  parent_comment_id :bigint
#
FactoryBot.define do
  factory :comment do
    
  end
end
