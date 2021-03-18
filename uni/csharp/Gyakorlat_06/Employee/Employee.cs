using System;

namespace Employee
{
    class Employee
    {
        public string Name { get; private set; }
        public DateTime BirthDate { get; private set; }
        public long Salary { get; private set; }

        private static readonly int Retirement = 65;
        private static readonly string[] Months = { "", "január", "február", "március", "április", "május", "június", "július", "augusztus", "szeptember", "október", "november", "december" };

        public Employee(string name, int year, string month, int day)
        {
            Name = name;

            int monthIndex = ConvertMonthName(month);
            if (monthIndex == 0)
                monthIndex = 1;

            BirthDate = new DateTime(year, monthIndex, day);
            Salary = 10000 * (DateTime.Now.Year - BirthDate.Year);
        }

        public Employee(string name, int year, int month, int day) : this(name, year, Months[month], day) { }

        public int YearsLeft()
        {
            return Retirement - (DateTime.Now.Year - BirthDate.Year);
        }

        public string ConvertMonthValue(int month)
        {
            return Months[month];
        }

        public int ConvertMonthName(string name)
        {
            for(int i = 0; i < Months.Length; i++)
            {
                if (Months[i] == name)
                    return i;
            }

            return 0;
        }

        public static Employee Younger(Employee e1, Employee e2)
        {
            return e1.YearsLeft() > e2.YearsLeft() ? e1 : e2;
        }

        public override string ToString()
        {
            return $"{Name}, {BirthDate.Year}. {ConvertMonthValue(BirthDate.Month)} {BirthDate.Day}. {Salary} {YearsLeft()}";
        }
    }
}