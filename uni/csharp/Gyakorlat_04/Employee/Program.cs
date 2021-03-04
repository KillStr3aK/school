using System;

namespace EmployeeManagement
{
    class Program
    {
        static void Main(string[] args)
        {
            Employee[] employees = new Employee[5];
            
            for(int i = 0; i < employees.Length; i++)
            {
                Console.WriteLine($"{i + 1}. employee name: ");
                string name = Console.ReadLine();

                Console.WriteLine($"{i + 1}. employee salary: ");
                long salary = Convert.ToInt64(Console.ReadLine());

                employees[i] = new Employee
                {
                    Name = name,
                    Salary = salary
                };
            }

            int highestSalary = 0;
            for(int i = 1; i < employees.Length; i++)
            {
                if (employees[i].HigherSalary(employees[highestSalary]))
                    highestSalary = i;
            }

            Console.WriteLine($"Highest salary: {employees[highestSalary].Display()}");

            int salaryCount = 0;
            for(int i = 0; i < employees.Length; i++)
            {
                if (employees[i].IsSalaryBetween(1000, 2000))
                    salaryCount++;
            }

            Console.WriteLine($"{salaryCount} employee has salary between 1000 & 2000");

            long averageSalary = 0;
            for(int i = 0; i < employees.Length; i++)
            {
                averageSalary += employees[i].Salary;
            }

            Console.WriteLine($"Average salary: {averageSalary / employees.Length}");

            long employeesTax = 0;
            for (int i = 0; i < employees.Length; i++)
            {
                employeesTax += employees[i].GetTax();
            }

            Console.WriteLine($"Total Tax: {employeesTax}");
        }
    }
}