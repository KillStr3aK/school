using System;
using System.Collections.Generic;

namespace Gyak9
{
    class Program
    {
        static void Main(string[] args)
        {
            List<EgyetemiAlkalmazott> Alkalmazottak = new List<EgyetemiAlkalmazott>();

            for(int i = 0; i < 5; i++)
            {
                Alkalmazottak.Add(new EgyetemiAlkalmazott($"Alkalmazott {i}", GetRandomInt(30, 60), $"ME", (Beosztas)GetRandomInt(0, 3)));
            }

            Kiiras(Alkalmazottak);
            Statisztika(Alkalmazottak);

            Alkalmazottak.Sort();
            Kiiras(Alkalmazottak);
        }

        static void Kiiras(List<EgyetemiAlkalmazott> lista)
        {
            foreach(EgyetemiAlkalmazott i in lista)
            {
                Console.WriteLine(i);
            }
        }

        static void Statisztika(List<EgyetemiAlkalmazott> lista)
        {
            Dictionary<Beosztas, int> beosztottDarab = new Dictionary<Beosztas, int>();

            foreach(EgyetemiAlkalmazott i in lista)
            {
                if (!beosztottDarab.ContainsKey(i.Beosztas)) beosztottDarab.Add(i.Beosztas, 1);
                else beosztottDarab[i.Beosztas]++;
            }

            Console.WriteLine();
            foreach (KeyValuePair<Beosztas, int> i in beosztottDarab)
            {
                Console.WriteLine($"{i.Key} {i.Value}");
            }

            Console.WriteLine();
        }

        static Random random = new Random();
        static int GetRandomInt(int min, int max)
        {
            return random.Next(min, max);
        }
    }
}