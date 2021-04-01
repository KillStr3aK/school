using System;
using Testek;

namespace HasabTest
{
    class Program
    {
        static void Main(string[] args)
        {
            HasabTest hasabok = new HasabTest(5);
            hasabok.Set(0, new Henger(1, 2));
            hasabok.Set(1, new Henger(1, 2));
            hasabok.Set(2, new Teglatest(1, 2, 3));

            Kiiras(hasabok);
            Console.WriteLine(hasabok.AtlagTerfogat());
            Console.WriteLine(hasabok.HengerDarabszam());
        }

        static void Kiiras(HasabTest ht)
        {
            for (int i = 0; i < ht.Darabszam(); i++)
            {
                Hasab hasab = ht.Get(i);

                if(hasab != null)
                    Console.WriteLine(hasab);
            }
        }
    }
}