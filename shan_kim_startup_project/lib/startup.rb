require "employee"

class Startup

    def initialize(name, funding, salaries)
        @name = name
        @funding = funding
        @salaries = salaries
        @employees = []
    end

    def name
        @name
    end

    def funding
        @funding
    end

    def salaries
        @salaries
    end

    def employees
        @employees
    end

    def valid_title?(title)
        salaries.has_key?(title)
    end

    def >(other_startup)
        @funding > other_startup.funding
    end

    def hire(employee_name, title)
        if !self.valid_title?(title)
            raise "title does not exist"
        end
        @employees << Employee.new(employee_name, title)
    end 

    def size
        @employees.length
    end

    def pay_employee(employee)
        amount = self.salaries[employee.title]
        raise "not enough funding" if amount > @funding
    
        employee.pay(amount)
        @funding -= amount
    end

    def payday
        @employees.each do |employee|
            self.pay_employee(employee)
        end
    end

    def average_salary
        sum = 0
        @employees.each do |employee|
            sum += salaries[employee.title]
        end
        sum / @employees.length
    end

    def close
        @employees = []
        @funding = 0
    end

    def acquire(another_startup)
        @funding += another_startup.funding
        another_startup.salaries.each do |title, amount|
            if !@salaries.has_key?(title)
                @salaries[title] = amount
            end
        end
        @employees += another_startup.employees
        another_startup.close()
    end

end
