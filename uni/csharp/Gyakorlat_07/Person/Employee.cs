using System;

namespace Person
{
    class Employee : Adult
    {
        public int Salary { get; private set; }
        public static int RetireAge = 65;

        public Employee(string name, int age, string work, int salary) : base(name, age, work)
        {
            Salary = salary;
        }

        public override string ToString()
        {
            return base.ToString() + " " + Salary;
        }
    }
}