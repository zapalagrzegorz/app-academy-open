# frozen_string_literal: true

# == Schema Information
#
# Table name: questions
#
#  id         :bigint           not null, primary key
#  text       :text
#  poll_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Question < ApplicationRecord
  belongs_to :poll,
             primary_key: :id,
             foreign_key: :poll_id,
             class_name: 'Poll'

  has_many :answer_choices,
           primary_key: :id,
           foreign_key: :question_id,
           class_name: 'AnswerChoice'

  #  bo ważne są odpowiedzi
  has_many :responses,
           through: :answer_choices,
           source: :responses
end
