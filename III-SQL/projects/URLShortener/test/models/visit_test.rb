# == Schema Information
#
# Table name: visits
#
#  id               :bigint           not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  shortened_url_id :bigint           not null
#  user_id          :bigint           not null
#
# Indexes
#
#  index_visits_on_shortened_url_id  (shortened_url_id)
#  index_visits_on_user_id           (user_id)
#
require 'test_helper'

class VisitTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
