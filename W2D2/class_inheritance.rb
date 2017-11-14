require 'byebug'
class Employee
  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end

  def bonus(multiplier)
    @salary * multiplier
  end
end

class Manager < Employee
  attr_reader :employees
  def initialize(name, title, salary, boss)
    super(name, title, salary, boss)
    @employees = []
  end

  def bonus(multiplier)
    debugger
    bonus = 0
    self.employees.each do |employee|
      bonus += employee.bonus(multiplier)
    end
    bonus
  end

  def add_employee(employee)
    @employees << employee
  end
end
