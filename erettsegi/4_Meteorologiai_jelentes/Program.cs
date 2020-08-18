using System;
using System.Collections.Generic;
using System.IO;

namespace TOMIKE
{
    class Program
    {
        class Jelentes
        {
            public string Telepules { get; set; }
            public string Ido { get; set; }
            public string Szelerosseg { get; set; }
            public int Homerseklet { get; set; }

            public Jelentes() { }
        }

        static List<Jelentes> jelentesek = new List<Jelentes>();
        static List<string> telepulesek = new List<string>();

        static void Main(string[] args)
        {
            Feladat1();
            Feladat2();
            Feladat3();
            Feladat4();
            Feladat5();
            Feladat6();
        }

        static void Feladat1()
        {
            FileStream fs = File.Open("tavirathu13.txt", FileMode.Open);
            StreamReader sr = new StreamReader(fs);

            string[] adatok;
            while(!sr.EndOfStream)
            {
                adatok = sr.ReadLine().Split(' ');
                jelentesek.Add(new Jelentes
                {
                    Telepules = adatok[0],
                    Ido = adatok[1],
                    Szelerosseg = adatok[2],
                    Homerseklet = Convert.ToInt32(adatok[3])
                });

                if (!telepulesek.Contains(adatok[0]))
                    telepulesek.Add(adatok[0]);
            }

            sr.Close();
            fs.Close();
        }
        static void Feladat2()
        {
            Console.WriteLine("2. feladat:");
            Console.WriteLine("Adja meg egy település kódját! Település:");
            string telepules = Console.ReadLine();

            Jelentes utolso = new Jelentes();
            foreach(Jelentes i in jelentesek)
            {
                if(i.Telepules == telepules)
                {
                    utolso = i;
                }
            }

            //Jelentes utolso2 = jelentesek.FindLast(x => x.Telepules == telepules);
            Console.WriteLine($"Az utolsó mérési adat a megadott településről {utolso.Ido.Insert(2, ":")}-kor érkezett.");
        }
        static void Feladat3()
        {
            Console.WriteLine("3. feladat:");
            Jelentes legmagasabb = jelentesek[0];
            Jelentes legalacsonyabb = jelentesek[0];

            foreach(Jelentes i in jelentesek)
            {
                if (i.Homerseklet > legmagasabb.Homerseklet) legmagasabb = i;
                else if (i.Homerseklet < legalacsonyabb.Homerseklet) legalacsonyabb = i;
            }

            Console.WriteLine($"A legalacsonyabb hőmérséklet: {legalacsonyabb.Telepules} {legalacsonyabb.Ido.Insert(2, ":")} {legalacsonyabb.Homerseklet} fok.");
            Console.WriteLine($"A legmagasabb hőmérséklet: {legmagasabb.Telepules} {legmagasabb.Ido.Insert(2, ":")} {legmagasabb.Homerseklet} fok.");
        }
        static void Feladat4()
        {
            Console.WriteLine("4. feladat:");

            int darab = 0;
            foreach(Jelentes i in jelentesek)
            {
                if (i.Szelerosseg == "00000")
                {
                    ++darab;
                    Console.WriteLine($"{i.Telepules} {i.Ido.Insert(2, ":")}");
                }
            }

            if (darab == 0) Console.WriteLine("Nem volt szélcsend a mérések idején.");
        }
        static void Feladat5()
        {
            Console.WriteLine("5. feladat:");
            foreach(string telepules in telepulesek)
            {
                bool NA = false;

                int legmagasabb = 0;
                int legalacsonyabb = 100;
                int[] meresek = { 0, 0, 0, 0 };

                foreach(Jelentes jelentes in jelentesek)
                {
                    if(jelentes.Telepules == telepules)
                    {
                        int ora = Convert.ToInt32($"{jelentes.Ido[0]}{jelentes.Ido[1]}");
                        if (ora == 1) meresek[0] = jelentes.Homerseklet;
                        else if (ora == 7) meresek[1] = jelentes.Homerseklet;
                        else if (ora == 13) meresek[2] = jelentes.Homerseklet;
                        else if (ora == 19) meresek[3] = jelentes.Homerseklet;

                        if (jelentes.Homerseklet < legalacsonyabb) legalacsonyabb = jelentes.Homerseklet;
                        else if (jelentes.Homerseklet > legmagasabb) legmagasabb = jelentes.Homerseklet;
                    }
                }

                for(int i = 0; i < 4; i++)
                {
                    if(meresek[i] == 0)
                    {
                        NA = true;
                        break;
                    }
                }

                if (!NA) Console.WriteLine($"{telepules} Középhőmérséklet: {Math.Round(((float)meresek[0] + meresek[1] + meresek[2] + meresek[3]) / 4)}; Hőmérséklet-ingadozás: {legmagasabb - legalacsonyabb}");
                else Console.WriteLine($"{telepules} NA; Hőmérséklet-ingadozás: {legmagasabb - legalacsonyabb}");
            }
        }
        static void Feladat6()
        {
            foreach(string telepules in telepulesek)
            {
                FileStream fs = File.Open($"{telepules}.txt", FileMode.Append);
                StreamWriter sw = new StreamWriter(fs);
                sw.WriteLine(telepules);

                foreach (Jelentes jelentes in jelentesek)
                {
                    if(jelentes.Telepules == telepules)
                    {
                        string erosseg = "";
                        for (int i = 0; i < Convert.ToInt32($"{jelentes.Szelerosseg[3]}{jelentes.Szelerosseg[4]}"); i++)
                            erosseg += "#";

                        sw.WriteLine($"{jelentes.Ido.Insert(2, ":")} {erosseg}");
                    }
                }

                sw.Close();
                fs.Close();
            }
        }
    }
}