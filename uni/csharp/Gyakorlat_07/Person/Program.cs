using System;

namespace Person
{
    class Program
    {
        static void Main(string[] args)
        {
            Person person1 = ReadPerson();
            Person person2 = ReadPerson();

            if (person1 is Adult) Console.WriteLine("'person1' is Adult");
            else Console.WriteLine("'person1' is Child");

            if (person2 is Child) Console.WriteLine("'person2' is Child");
            else Console.WriteLine("'person2' is Adult");

            Console.WriteLine();

            int n = ReadIntCheck("People count: ");
            Person[] people = new Person[n];

            for(int i = 0; i < people.Length; i++)
            {
                people[i] = ReadPerson();
            }

            PrintSortedArray(people);
        }

        static void PrintSortedArray(Person[] people)
        {
            for(int i = 0; i < people.Length; i++)
            {
                int min = i;

                for(int k = i + 1; k < people.Length; k++)
                {
                    if (people[k].Age < people[min].Age)
                        min = k;
                }

                if(min != i)
                {
                    Person temp = people[i];
                    people[i] = people[min];
                    people[min] = temp;
                }
            }

            foreach(Person i in people)
            {
                Console.WriteLine(i);
            }
        }

        static Person ReadPerson()
        {
            Person person;
            Console.Write("Person name: ");
            string name = Console.ReadLine();

            Console.Write("Person age: ");
            int age = Convert.ToInt32(Console.ReadLine());

            if(age < 18)
            {
                Console.Write("Child school: ");
                string school = Console.ReadLine();
                person = new Child(name, age, school);
            } else
            {
                Console.Write("Adult work: (empty if none) ");
                string work = Console.ReadLine();

                if (string.IsNullOrEmpty(work)) person = new Adult(name, age, null);
                else
                {
                    int salary = ReadInt("Employee salary: ");
                    person = new Employee(name, age, work, salary);
                }
            }

            return person;
        }

        static int ReadIntCheck(string msg)
        {
            Console.Write(msg);

            int num;
            while (!int.TryParse(Console.ReadLine(), out num))
            {
                Console.WriteLine("Invalid input");
            }

            return num;
        }

        static int ReadInt(string msg)
        {
            Console.Write(msg);
            return Convert.ToInt32(Console.ReadLine());
        }
    }
}