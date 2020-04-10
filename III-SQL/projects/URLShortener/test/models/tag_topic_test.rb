# == Schema Information
#
# Table name: tag_topics
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_tag_topics_on_title  (title) UNIQUE
#
require 'test_helper'

class TagTopicTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
