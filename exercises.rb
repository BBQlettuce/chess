class Employee
  attr_reader :salary, :boss

  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end

  def bonus(multiplier)
    salary * multiplier
  end

end

def Manager < Employee

  attr_accessor :employees
  def initialize
    super (name, title, salary, boss = nil)
    @employees = []
  end

  def add_employee(employee)
    self.employees << employee if employee.boss == name
  end

  def bonus(multiplier)
    #total salary of all sub-employees * multiplier
    salaries = []
    employees.each do |e|
      salaries << e.salary
      if e.boss
    end
  end

  def employee_sum
    return salary if employees.nil?
    employee_array = employees
    accumulator = 0
    until employee_array.empty?
      current_employee = employee_array.shift
      accumulator += current_employee.salary
      employee_array += current_employee.employees if current_employee.employees
    end
  end
end
