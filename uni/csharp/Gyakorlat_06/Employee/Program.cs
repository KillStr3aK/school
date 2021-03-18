using System;

namespace Employee
{
    class Program
    {
        static void Main(string[] args)
        {
            int employeeCount = ReadInt("Employee amount");
            Employee[] employees = new Employee[employeeCount];

            for(int i = 0; i < employees.Length; i++)
            {
                Console.Write(i + 1 + ". employee name: ");
                string name = Console.ReadLine();

                int year = ReadInt("Employee birth year: ");
                int month = ReadInt("Employee birth month: ");
                int day = ReadInt("Employee birth day: ");
                employees[i] = new Employee(name, year, month, day);
            }

            PrintArray(employees);
            Console.WriteLine("Retirement check");
            RetirementCheck(employees);

            Console.WriteLine("More than average");
            MoreThanAverage(employees);

            Console.WriteLine("Sort by ascending");
            SortAscending(employees);
            PrintArray(employees);

            Console.WriteLine("Sort by descending");
            SortDescending(employees);
            PrintArray(employees);
        }

        static void PrintArray(Employee[] arr)
        {
            foreach(Employee i in arr)
            {
                Console.WriteLine(i);
            }
        }

        static void RetirementCheck(Employee[] arr)
        {
            foreach(Employee i in arr)
            {
                if (i.YearsLeft() < 5)
                    Console.WriteLine(i);
            }
        }

        static void MoreThanAverage(Employee[] arr)
        {
            int average = AverageRetirement(arr);
            foreach (Employee i in arr)
            {
                if (i.YearsLeft() > average)
                    Console.WriteLine(i);
            }
        }

        static int AverageRetirement(Employee[] arr)
        {
            int average = 0;
            foreach (Employee i in arr)
            {
                average += i.YearsLeft();
            }

            return average / arr.Length;
        }

        static void SortAscending(Employee[] arr)
        {
            for(int i = 0; i < arr.Length; i++)
            {
                int index = i;

                for(int k = i + 1; k < arr.Length; k++)
                {
                    if (arr[k].YearsLeft() < arr[index].YearsLeft())
                        index = k;
                }

                if(index != i)
                {
                    Employee temp = arr[i];
                    arr[i] = arr[index];
                    arr[index] = temp;
                }
            }
        }

        static void SortDescending(Employee[] arr)
        {
            for (int i = 0; i < arr.Length; i++)
            {
                int index = i;

                for (int k = i + 1; k < arr.Length; k++)
                {
                    if (arr[k].YearsLeft() > arr[index].YearsLeft())
                        index = k;
                }

                if (index != i)
                {
                    Employee temp = arr[i];
                    arr[i] = arr[index];
                    arr[index] = temp;
                }
            }
        }

        static int ReadInt(string msg)
        {
            Console.WriteLine(msg);
            return Convert.ToInt32(Console.ReadLine());
        }
    }
}