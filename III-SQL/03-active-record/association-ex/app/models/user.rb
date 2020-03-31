# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  # enrollments and enrolled_courses.
  has_many :enrollments,
           primary_key: :id,
           foreign_key: :student_id,
           class_name: 'Enrollment'

  has_many :enrolled_courses, through: :enrollments, source: :course
  # prerequisite
  #  prereq_id

  has_one :course_instructor,
          primary_key: :id,
          foreign_key: :instructor_id,
          class_name: 'Course'
end
