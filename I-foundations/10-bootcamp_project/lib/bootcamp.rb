# frozen_string_literal: true

class Bootcamp
  def initialize(name, slogan, student_capacity)
    @name = name
    @slogan = slogan
    @student_capacity = student_capacity
    @teachers = []
    @students = []
    @grades = Hash.new { |h, k| h[k] = [] }
  end

  def name
    @name
  end

  def slogan
    @slogan
  end

  def teachers
    @teachers
  end

  def students
    @students
  end

  def hire(teacher)
    @teachers << teacher
  end

  def enroll(student)
    # p @student_capacity
    # p @students.length
    if @student_capacity > @students.length
      #   p @students
      @students << student
      p students
      true
    else
      false
    end
  end

  def enrolled?(student)
    students.include?(student)
  end

  def student_to_teacher_ratio
    students.length / teachers.length
  end

  def add_grade(student, grade)
    if self.enrolled?(student)
      # if students.include?(student)
      @grades[student] << grade
      true
    else
      false
    end
  end

  def num_grades(student)
    @grades[student].length
  end

  def average_grade(student)
    if !enrolled?(student) || num_grades(student).zero?
      # if @grades[student].empty?
      nil
    else
      @grades[student].sum / @grades[student].length
    end
  end
end
