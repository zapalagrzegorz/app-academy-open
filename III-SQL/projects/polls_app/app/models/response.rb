# frozen_string_literal: true

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
class Response < ApplicationRecord
  belongs_to :answer_choice,
             primary_key: :id,
             foreign_key: :answer_choice_id,
             class_name: 'AnswerChoice'

  belongs_to :user,
             primary_key: :id,
             foreign_key: :user_id,
             class_name: 'User'

  has_one :question,
          through: :answer_choice,
          source: :question
end
