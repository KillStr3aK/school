using System;

namespace Person
{
    class Program
    {
        static void Main(string[] args)
        {
            Person person = new Person();

            Console.WriteLine("Név:");
            person.Name = Console.ReadLine();

            Console.WriteLine("Súly:");
            person.Weight = Convert.ToInt32(Console.ReadLine());

            Console.WriteLine("Magasság:");
            person.Height = Convert.ToInt32(Console.ReadLine());

            Console.WriteLine(person.Get() + $" TTI: {person.TTI()}");
        }
    }
}