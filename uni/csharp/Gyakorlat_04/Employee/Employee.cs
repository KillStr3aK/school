using System;

namespace EmployeeManagement
{
    class Employee
    {
        public string Name { get; set; }
        public long Salary { get; set; }

        public Employee() { }

        public Employee(string name, long salary)
        {
            Name = name;
            Salary = salary;
        }

        public Employee(string name) : this(name, 250000) { }

        public void IncreaseSalary(long salary)
        {
            Salary += salary;
        }

        public bool IsSalaryBetween(long min, long max)
        {
            return Salary >= min && Salary <= max;
        }

        public long GetTax()
        {
            return (long)(Salary * 0.16);
        }

        public bool HigherSalary(Employee employee)
        {
            return Salary > employee.Salary;
        }

        public override string ToString()
        {
            return Name + " " + Salary;
        }
    }
}