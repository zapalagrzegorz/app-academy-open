# == Schema Information
#
# Table name: responses
#
#  id               :bigint           not null, primary key
#  user_id          :bigint
#  answer_choice_id :bigint
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
require 'test_helper'

class ResponseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
