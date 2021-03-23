using System;
using System.IO;
using System.Collections.Generic;

namespace TOMIKE
{
    class Program
    {
        class Sorozat
        {
            public string Datum { get; set; }
            public string Nev { get; set; }
            public string Resz { get; set; }
            public int Hosszusag { get; set; }
            public bool Megnezte { get; set; }

            public Sorozat() { }

            public override string ToString()
            {
                return $"{Resz}\t{Nev}";
            }
        }

        static List<Sorozat> Sorozatok = new List<Sorozat>();

        static void Main(string[] args)
        {
            Feladat1();
            Feladat2();
            Feladat3();
            Feladat4();
            Feladat5();
            Feladat7();
            Feladat8();
        }

        static void Feladat1()
        {
            FileStream fs = File.Open("lista.txt", FileMode.Open);
            StreamReader sr = new StreamReader(fs);

            while(!sr.EndOfStream)
            {
                Sorozatok.Add(new Sorozat
                {
                    Datum = sr.ReadLine(),
                    Nev = sr.ReadLine(),
                    Resz = sr.ReadLine(),
                    Hosszusag = Convert.ToInt32(sr.ReadLine()),
                    Megnezte = Convert.ToBoolean(Convert.ToInt32(sr.ReadLine()))
                });
            }

            sr.Close();
            fs.Close();
        }

        static void Feladat2()
        {
            Console.WriteLine("2. feladat: ");

            int db = 0;
            foreach(Sorozat i in Sorozatok)
            {
                if (i.Datum != "NI")
                    ++db;
            }

            Console.WriteLine($"A listában {db} db vetítési dátummal rendelkező epizód van.");
        }

        static void Feladat3()
        {
            Console.WriteLine("3. feladat: ");

            int db = 0;
            foreach(Sorozat i in Sorozatok)
            {
                if (i.Megnezte)
                    ++db;
            }

            Console.WriteLine($"A listában lévő epizódok {100.0f / Sorozatok.Count * db:0.##}%-át látta.");
        }

        static void Feladat4()
        {
            Console.WriteLine("4. feladat: ");
            int perc = 0;
            foreach(Sorozat i in Sorozatok)
            {
                if(i.Megnezte)
                    perc += i.Hosszusag;
            }

            int nap = perc / 1440;
            perc -= nap * 1440;

            int ora = perc / 60;
            perc -= ora * 60;
            Console.WriteLine($"Sorozatnézéssel {nap} napot {ora} órát és {perc} percet töltött.");
        }

        static void Feladat5()
        {
            Console.WriteLine("5. feladat: ");
            Console.Write("Adjon meg egy dátumot! Dátum= ");

            if(DateTime.TryParse(Console.ReadLine(), out DateTime datum))
            {
                foreach(Sorozat i in Sorozatok)
                {
                    if (i.Megnezte)
                        continue;

                    if (i.Datum == "NI")
                        continue;

                    if(DateTime.TryParse(i.Datum, out DateTime datum2))
                    {
                        if(datum2 <= datum)
                        {
                            Console.WriteLine(i);
                        }
                    }
                }
            }
        }

        static void Feladat7()
        {
            Console.WriteLine("7. feladat: ");
            Console.Write("Adja meg a hét egy napját (például cs)! Nap= ");
            string nap = Console.ReadLine();

            int db = 0;
            List<string> nevek = new List<string>();
            foreach (Sorozat i in Sorozatok)
            {
                if (i.Datum == "NI")
                    continue;

                if (nevek.Contains(i.Nev))
                    continue;

                string[] datum = i.Datum.Split('.');
                if(hetnapja(Convert.ToInt32(datum[0]), Convert.ToInt32(datum[1]), Convert.ToInt32(datum[2])) == nap)
                {
                    ++db;
                    Console.WriteLine(i.Nev);
                    nevek.Add(i.Nev);
                }
            }

            if(db == 0)
            {
                Console.WriteLine("Az adott napon nem kerül adásba sorozat.");
            }
        }

        static void Feladat8()
        {
            List<string> nevek = new List<string>();
            foreach(Sorozat i in Sorozatok)
            {
                if (!nevek.Contains(i.Nev))
                    nevek.Add(i.Nev);
            }

            FileStream fs = File.Open("summa.txt", FileMode.Create);
            StreamWriter sw = new StreamWriter(fs);

            foreach(string i in nevek)
            {
                int hossz = 0;
                int epizodok = 0;

                foreach(Sorozat k in Sorozatok)
                {
                    if (k.Nev != i)
                        continue;

                    hossz += k.Hosszusag;
                    epizodok++;
                }

                sw.WriteLine($"{i} {hossz} {epizodok}");
            }

            sw.Close();
            fs.Close();
        }

        static string hetnapja(int ev, int ho, int nap)
        {
            string[] napok = { "v", "h", "k", "sze", "cs", "p", "szo" };
            int[] honapok = { 0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4 };

            if (ho < 3) ev -= 1;
            return napok[(ev + ev / 4 - ev / 100 + ev / 400 + honapok[ho - 1] + nap) % 7];
        }
    }
}