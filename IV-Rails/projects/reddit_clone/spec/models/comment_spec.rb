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
require 'rails_helper'

RSpec.describe Comment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
