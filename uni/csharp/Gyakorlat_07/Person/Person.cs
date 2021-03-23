using System;

namespace Person
{
    class Person
    {
        public string Name { get; private set; }
        public int Age { get; private set; }

        public Person(string name, int age)
        {
            Name = name;
            Age = age;
        }

        public bool Compare(Person person)
        {
            return person.Age < Age;
        }

        public override string ToString()
        {
            return $"{Name} {Age}";
        }
    }
}