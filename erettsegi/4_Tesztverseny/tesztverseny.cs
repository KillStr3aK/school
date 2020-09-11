using System;
using System.Collections.Generic;
using System.IO;

namespace tesztverseny
{
    class tesztverseny
    {
        public class Versenyzo
        {
            public string Azonosito;
            public string Valaszok;
            public int Pontszam;

            public Versenyzo() { }
        }

        static List<Versenyzo> Versenyzok = new List<Versenyzo>();
        static string Valaszok;

        static void Main(string[] args)
        {
            Feladat1();
            Feladat2();
            Feladat3();
            Feladat5();
            Feladat6();
            Feladat7();
        }

        static void Feladat1()
        {
            Console.WriteLine("1. feladat: Az adatok beolvasása\n");
            FileStream fs = File.Open("valaszok.txt", FileMode.Open);
            StreamReader sr = new StreamReader(fs);

            Valaszok = sr.ReadLine();
            while(!sr.EndOfStream)
            {
                string[] darab = sr.ReadLine().Split(' ');
                Versenyzok.Add(new Versenyzo
                {
                    Azonosito = darab[0],
                    Valaszok = darab[1],
                    Pontszam = 0
                });
            }

            sr.Close();
            fs.Close();
        }

        static void Feladat2()
        {
            Console.WriteLine($"2. feladat: A vetélkedőn {Versenyzok.Count} versenyző indult.\n");
        }

        static void Feladat3()
        {
            Console.Write("3. feladat: A versenyző azonosítója = ");
            string azonosito = Console.ReadLine();

            Versenyzo versenyzo = Versenyzok.Find(x => x.Azonosito == azonosito);
            Console.WriteLine($"{versenyzo.Valaszok} (a versenyző válasza)\n");
            Feladat4(versenyzo); //Az is elég ha csak a válaszait adod tovább, nem az egész versenyzőt
            
            /* vagy
            foreach(Versenyzo i in Versenyzok)
            {
                if(i.Azonosito == azonosito)
                {
                    Console.WriteLine($"{i.Valaszok} (a versenyző válasza)");
                    Feladat4(i);
                    break;
                }
            }
            */
        }

        static void Feladat4(Versenyzo versenyzo)
        {
            Console.WriteLine(Valaszok);
            for(int i = 0; i < 14; i++)
            {
                Console.Write(versenyzo.Valaszok[i] == Valaszok[i] ? "+" : " ");
            }

            /* vagy
            for(int i = 0; i < 14; i++)
            {
                if(versenyzo.Valaszok[i] == Valaszok[i])
                {
                    Console.Write("+");
                } else
                {
                    Console.Write(" ");
                }
            }
            */
        }

        static void Feladat5()
        {
            Console.Write("\n\n5. feladat: A feladat sorszáma = ");
            int feladat = Convert.ToInt32(Console.ReadLine());

            int darab = 0;
            foreach(Versenyzo i in Versenyzok)
            {
                if (i.Valaszok[feladat] == Valaszok[feladat])
                    darab++;
            }

            Console.WriteLine($"A feladatra {darab} fő, a versenyzők {(darab / Versenyzok.Count) * 100.0f}%-a adott helyes választ.\n");
        }

        static void Feladat6()
        {
            Console.WriteLine("6. feladat: A versenyzők pontszámának meghatározása\n");

            FileStream fs = File.Open("pontok.txt", FileMode.Append);
            StreamWriter sw = new StreamWriter(fs);

            foreach(Versenyzo versenyzo in Versenyzok)
            {
                for(int i = 0; i < 14; i++)
                {
                    if(versenyzo.Valaszok[i] == Valaszok[i])
                    {
                        if (i <= 5) versenyzo.Pontszam += 3;
                        else if (i <= 10) versenyzo.Pontszam += 4;
                        else if (i <= 13) versenyzo.Pontszam += 5;
                        else versenyzo.Pontszam += 6;
                    }
                }

                sw.WriteLine($"{versenyzo.Azonosito} {versenyzo.Pontszam}");
            }

            sw.Close();
            fs.Close();
        }

        static void Feladat7()
        {
            Console.WriteLine("7. feladat: A verseny legjobbjai:");

            for(int i = 1; i < Versenyzok.Count; i++)
            {
                for(int k = 0; k < Versenyzok.Count - i; k++)
                {
                    if(Versenyzok[k].Pontszam < Versenyzok[k + 1].Pontszam)
                    {
                        Versenyzo temp = Versenyzok[k + 1];
                        Versenyzok[k + 1] = Versenyzok[k];
                        Versenyzok[k] = temp;
                    }
                }
            }

            int dij = 1;
            Console.WriteLine($"1. díj ({Versenyzok[0].Pontszam} pont): {Versenyzok[0].Azonosito}");

            for (int i = 1; i < Versenyzok.Count; i++)
            {
                if (Versenyzok[i].Pontszam > Versenyzok[i + 1].Pontszam)
                {
                    ++dij;
                    if (dij == 4)
                        break;
                }

                Console.WriteLine($"{dij}. díj ({Versenyzok[i].Pontszam} pont): {Versenyzok[i].Azonosito}");
            }
        }
    }
}
