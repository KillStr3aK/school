using System;
using System.IO;
using System.Linq;
using System.Collections.Generic;

namespace tomikaasd
{
    class futar
    {
        class Fuvar
        {
            public int Nap { get; set; }
            public int Hanyadik { get; set; }
            public int Tavolsag { get; set; }

            public Fuvar() { }

            public Fuvar(int nap, int hanyadik, int tavolsag)
            {
                Nap = nap;
                Hanyadik = hanyadik;
                Tavolsag = tavolsag;
            }
        }

        static List<Fuvar> Fuvarok = new List<Fuvar>();

        static void Main(string[] args)
        {
            Feladat1();
            Feladat2();
            Console.WriteLine();
            Feladat3();
            Console.WriteLine();
            Feladat4();
            Console.WriteLine();
            Feladat5();
            Console.WriteLine();
            Feladat6();
            Console.WriteLine();
            Feladat7();
            Console.WriteLine();
            Feladat8();
            Feladat9();
        }

        static void Feladat1()
        {
            FileStream fs = File.Open("tavok.txt", FileMode.Open, FileAccess.Read);
            StreamReader sr = new StreamReader(fs);

            while (!sr.EndOfStream)
            {
                string[] darab = sr.ReadLine().Split(' ');
                Fuvarok.Add(new Fuvar(Convert.ToInt32(darab[0]), Convert.ToInt32(darab[1]), Convert.ToInt32(darab[2])));
            }

            sr.Close();
            fs.Close();
        }

        static void Feladat2()
        {
            Console.WriteLine("2. feladat:");

            int legkisebbNap = Fuvarok[0].Nap;
            foreach(Fuvar i in Fuvarok)
            {
                if (i.Nap < legkisebbNap)
                {
                    legkisebbNap = i.Nap;
                }
            }

            Fuvar legelsoFuvar = Fuvarok[0];
            for(int i = 1; i < Fuvarok.Count; i++)
            {
                if (Fuvarok[i].Nap != legkisebbNap)
                    continue;

                if(Fuvarok[i].Hanyadik < legelsoFuvar.Hanyadik)
                {
                    legelsoFuvar = Fuvarok[i];
                }
            }

            Console.WriteLine($"A hét legelső útja {legelsoFuvar.Nap}. nap, {legelsoFuvar.Tavolsag} km");
        }

        static void Feladat3()
        {
            Console.WriteLine("3. feladat:");

            int legnagyobbNap = Fuvarok[0].Nap;
            foreach (Fuvar i in Fuvarok)
            {
                if (i.Nap > legnagyobbNap)
                {
                    legnagyobbNap = i.Nap;
                }
            }

            Fuvar legutolsoFuvar = Fuvarok[0];
            for (int i = 1; i < Fuvarok.Count; i++)
            {
                if (Fuvarok[i].Nap != legnagyobbNap)
                    continue;

                if (Fuvarok[i].Hanyadik > legutolsoFuvar.Hanyadik)
                {
                    legutolsoFuvar = Fuvarok[i];
                }
            }

            Console.WriteLine($"A hét legutolsó útja {legutolsoFuvar.Nap}. nap, {legutolsoFuvar.Tavolsag} km");
        }

        static void Feladat4()
        {
            Console.WriteLine("4. feladat:");

            bool[] dolgozott = new bool[8];
            foreach(Fuvar i in Fuvarok)
            {
                dolgozott[i.Nap] = true;
            }

            for(int i = 1; i < 8; i++)
            {
                if(!dolgozott[i])
                {
                    Console.WriteLine($"A(z) {i}. nap szabadnap volt!");
                }
            }
        }

        static void Feladat5()
        {
            Console.WriteLine("5. feladat:");

            int[] fuvarDb = new int[8];
            foreach (Fuvar i in Fuvarok)
            {
                fuvarDb[i.Nap] = 0;
            }

            foreach(Fuvar i in Fuvarok)
            {
                fuvarDb[i.Nap]++;
            }

            for(int i = 1; i < 8; i++)
            {
                if (fuvarDb[i] == 0)
                    continue;

                Console.WriteLine($"{i}. napon {fuvarDb[i]} fuvar volt.");
            }
        }

        static void Feladat6()
        {
            Console.WriteLine("6. feladat:");

            int[] fuvarKm = new int[8];
            foreach (Fuvar i in Fuvarok)
            {
                fuvarKm[i.Nap] = 0;
            }

            /*
            for(int i = 0; i < Fuvarok.Count; i++)
            {
                fuvarKm[Fuvarok[i].Nap] = 0;
            }
            */

            foreach (Fuvar i in Fuvarok)
            {
                fuvarKm[i.Nap] += i.Tavolsag;
            }

            /*
            for(int i = 0; i < Fuvarok.Count; i++)
            {
                fuvarKm[Fuvarok[i].Nap] += Fuvarok[i].Tavolsag;
            }
            */

            for (int i = 1; i < 8; i++)
            {
                if (fuvarKm[i] == 0)
                    continue;

                Console.WriteLine($"{i}. nap: {fuvarKm[i]} km");
            }
        }

        static void Feladat7()
        {
            Console.WriteLine("7. feladat:");

            Console.Write("Adj meg egy kilometert: ");
            int km = Convert.ToInt32(Console.ReadLine());
            Console.WriteLine($"A futár fizetése {km} km-ért {Fizetes(km)} Ft.");
        }

        static void Feladat8()
        {
            FileStream fs = File.Open("dijazas.txt", FileMode.Create, FileAccess.Write);
            StreamWriter sw = new StreamWriter(fs);

            Fuvarok = Fuvarok.OrderBy(x => x.Hanyadik).ToList();

            for(int i = 1; i < 8; i++)
            {
                foreach (Fuvar fuvar in Fuvarok)
                {
                    if (fuvar.Nap != i)
                        continue;

                    sw.WriteLine($"{i}. nap {fuvar.Hanyadik}. út: {Fizetes(fuvar.Tavolsag)}");
                }
            }

            sw.Close();
            fs.Close();
        }

        static void Feladat9()
        {
            Console.WriteLine("9. feladat:");
            int fizetes = 0;

            foreach(Fuvar i in Fuvarok)
            {
                fizetes += Fizetes(i.Tavolsag);
            }

            Console.WriteLine($"A futár a heti munkájáért {fizetes} Ft-t kap.");
        }

        static int Fizetes(int km)
        {
            if (km < 2) return 500;
            else if (km < 5) return 700;
            else if (km < 10) return 900;
            else if (km < 20) return 1400;
            
            return 2000;
        }
    }
}