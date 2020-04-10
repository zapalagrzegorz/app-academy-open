# == Schema Information
#
# Table name: taggings
#
#  id               :bigint           not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  shortened_url_id :bigint           not null
#  tag_topic_id     :bigint           not null
#
# Indexes
#
#  index_taggings_on_shortened_url_id                   (shortened_url_id)
#  index_taggings_on_tag_topic_id_and_shortened_url_id  (tag_topic_id,shortened_url_id) UNIQUE
#
require 'test_helper'

class TaggingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
