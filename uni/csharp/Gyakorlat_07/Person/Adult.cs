using System;

namespace Person
{
    class Adult : Person
    {
        public string Work { get; private set; }

        public Adult(string name, int age, string work) : base(name, age)
        {
            Work = work;
        }

        public override string ToString()
        {
            return base.ToString() + " " + Work;
        }
    }
}