# == Schema Information
#
# Table name: answer_choices
#
#  id          :bigint           not null, primary key
#  text        :text             not null
#  question_id :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'test_helper'

class AnswerChoiceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
