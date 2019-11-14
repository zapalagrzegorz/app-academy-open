class Employee
  attr_reader :name, :title, :salary, :boss
  include Enumerable

  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end

  def bonus(multiplier)
    puts @salary * multiplier
    @salary * multiplier
  end

  # private

  def employees_salary
    sum = 0

    # if !@employees.nil?
    @employees.each do |employee|
      if employee.employees
        sum += employee.salary + employee.employees_salary
      else
        sum += employee.salary
      end
    end
    # end

    sum
  end
end
