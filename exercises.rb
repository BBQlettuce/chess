class Employee
  attr_reader :salary, :boss, :name

  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end

  def bonus(multiplier)
    salary * multiplier
  end

  def employees
    @employees
  end

end

class Manager < Employee

  attr_accessor :employees
  def initialize(name, title, salary, boss = nil)
    super(name, title, salary, boss = nil)
    @employees = []
  end

  def add_employee(employee)
    self.employees << employee if employee.boss.name == name
  end

  def bonus(multiplier)
    employee_sum * multiplier
  end

  def employee_sum
    employee_array = employees
    accumulator = 0
    until employee_array.empty?
      current_employee = employee_array.shift
      accumulator += current_employee.salary
      if current_employee.employees
        employee_array += current_employee.employees
      end
    end
    accumulator
  end

end
