using System;

namespace Person
{
    class Child : Person
    {
        public string School { get; private set; }

        public Child(string name, int age, string school) : base(name, age)
        {
            School = school;
        }

        public override string ToString()
        {
            return base.ToString() + " " + School;
        }
    }
}