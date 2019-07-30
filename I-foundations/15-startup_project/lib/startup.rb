require "employee"

class Startup
  attr_reader :name, :funding, :salaries, :employees

  def initialize(name, funds, salaries)
    @name = name
    @funding = funds
    @salaries = salaries
    @employees = []
  end

  def valid_title?(title)
    salaries.has_key?(title)
  end

  def >(startup)
    funding > startup.funding
  end

  def hire(name, title)
    unless valid_title?(title)
      raise "No such title of employee "
    end
    employees << Employee.new(name, title)
  end

  def size
    employees.length
  end

  def pay_employee(employee)
    salary = salaries[employee.title]
    if funding < salary
      raise "Not enough funds"
    end
    employee.pay(salary)
    @funding -= salary
  end

  def payday
    employees.each { |e| pay_employee(e) }
  end

  def average_salary
    employees_salaries = 0
    employees.each { |employee| employees_salaries += salaries[employee.title] }
    employees_salaries / salaries.length
  end

  def close
    @employees = []
    @funding = 0
  end

  def acquire(another_startup)
    @funding += another_startup.funding
    @salaries = another_startup.salaries.merge(self.salaries)
    @employees.concat(another_startup.employees)
    another_startup.close
  end
end
