require "byebug"
require_relative "Employee"

class Manager < Employee
  include Enumerable

  attr_reader :employees

  def initialize(name, title, salary, boss = nil)
    super(name, title, salary, boss)
    @employees = []
  end

  def bonus(multiplier)
    # salary = employees_salary
    debugger
    return total_subsalary * multiplier
  end

  def add_employee(subordinate)
    employees << subordinate

    subordinate
  end

  def each
    # "each" is the base method called by all the iterators so you only have to define it
    unless @employees.nil?
      debugger
      @employess.each do |val|
        yield val
      end
    end
    # change or manipulate the values in your value array inside this block
    #   yield value
    # end
  end

  def employees_salary
    super
  end

  #   private

  def total_subsalary
    debugger
    total_subsalary = 0

    @employees.each do |employee|
      if employee.respond_to?(:employees)
        total_subsalary += employee.salary + employee.total_subsalary
      else
        total_subsalary += employee.salary
      end
    end

    total_subsalary
  end

  def total_subsalary_reduce
    debugger
    reduce do |memo, employee|
      p memo
      p employee
      memo.salary + employee.salary
    end
  end
end
