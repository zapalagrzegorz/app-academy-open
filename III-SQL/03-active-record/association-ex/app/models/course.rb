# frozen_string_literal: true

# == Schema Information
#
# Table name: courses
#
#  id            :bigint           not null, primary key
#  name          :string
#  prereq_id     :integer
#  instructor_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Course < ApplicationRecord
  # Course

  has_many :enrollments,
           primary_key: :id,
           foreign_key: :course_id,
           class_name: 'Enrollment'

  has_many :enrolled_students,
           through: :enrollments,
           source: :user

  # Remember, belongs_to is just a method where the first argument is
  # the name of the association, and the second argument is an options
  # hash.
  # In rails 5 we must specify this association to be optional, because some
  # courses will not have a prerequisite.
  belongs_to :prerequisite,
             primary_key: :id,
             foreign_key: :prereq_id,
             class_name: 'Course',
             optional: true

  belongs_to :instructor,
             primary_key: :id,
             foreign_key: :instructor_id,
             class_name: 'User'
end
