using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Tarsalgo
{
    class Program
    {
        struct Ajto
        {
            public int ora;
            public int perc;
            public int szemely;
            public bool irany;

            public Ajto (int o, int p, int sz, bool i)
            {
                ora = o;
                perc = p;
                szemely = sz;
                irany = i;
            }
        }
        static List<Ajto> ajtok = new List<Ajto>();

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
            FileStream stream = File.Open("C:\\Users\\stats\\Desktop\\4_Tarsalgo\\ajto.txt", FileMode.Open);
            StreamReader reader = new StreamReader(stream);

            string sor;
            string[] darabok;
            while(!reader.EndOfStream)
            {
                sor = reader.ReadLine();
                darabok = sor.Split(' ');

                int ora = Convert.ToInt32(darabok[0]);
                int perc = Convert.ToInt32(darabok[1]);
                int szemely = Convert.ToInt32(darabok[2]);
                bool irany = darabok[3] == "be" ? true : false;
                ajtok.Add(new Ajto(ora, perc, szemely, irany));
            }

            reader.Close();
            stream.Close();
        }
        static void Feladat2()
        {
            Console.WriteLine("2. feladat:");
            Console.WriteLine("Az első belépő: " + ajtok[0].szemely);

            int i = ajtok.Count - 1;
            while(i >= 0)
            {
                if(!ajtok[i].irany)
                {
                    Console.WriteLine("Az utolsó kilépő: " + ajtok[i].szemely);
                    break;
                }

                --i;
            }
            Console.WriteLine();
        }
        static void Feladat3()
        {
            int[] alkalom = new int[50];
            foreach(Ajto ajto in ajtok)
            {
                ++alkalom[ajto.szemely];
            }

            FileStream fajl = File.Open("C:\\Users\\stats\\Desktop\\4_Tarsalgo\\athaladas.txt", FileMode.Create);
            StreamWriter writer = new StreamWriter(fajl);

            for(int i = 0; i < 50; i++)
            {
                if(alkalom[i] > 0)
                    writer.WriteLine(i + " " + alkalom[i]);
            }

            writer.Close();
            fajl.Close();
        }
        static void Feladat4()
        {
            Console.WriteLine("4. feladat:");
            bool[] allapot = new bool[50];

            foreach(Ajto ajto in ajtok)
            {
                allapot[ajto.szemely] = ajto.irany;
            }

            for(int i = 0; i < 50; i++)
            {
                if (allapot[i])
                    Console.Write(i + " ");
            }
            Console.WriteLine();
            Console.WriteLine();
        }
        static void Feladat5() 
        {
            int letszam = 0;
            int max = 0;

            int ora = 0;
            int perc = 0;

            foreach(Ajto ajto in ajtok)
            {
                if (ajto.irany) ++letszam;
                else --letszam;

                if(letszam > max)
                {
                    max = letszam;
                    ora = ajto.ora;
                    perc = ajto.perc;
                }
            }

            Console.WriteLine("5. feladat:");
            Console.WriteLine("Például " + ora + ":" + perc + "-kor voltak a legtöbben a társalgóban.");
            Console.WriteLine();
        }
        static void Feladat6()
        {
            Console.WriteLine("6. feladat:");
            Console.WriteLine("Adja meg a személy azonosítóját!");
            int azonosito = Convert.ToInt32(Console.ReadLine());
            Feladat7(azonosito);
            Console.WriteLine();
        }
        static void Feladat7(int szemely)
        {
            foreach(Ajto ajto in ajtok)
            {
                if (ajto.szemely != szemely) continue;
                if (ajto.irany)
                {
                    Console.Write(ajto.ora + ":" + ajto.perc + "-");
                } else
                {
                    Console.Write(ajto.ora + ":" + ajto.perc);
                    Console.WriteLine();
                }
            }
            Console.WriteLine();
            Feladat8(szemely);
        }
        static void Feladat8(int szemely)
        {
            int osszesen = 0;
            int perc = 0;
            bool bent = false;

            foreach(Ajto i in ajtok)
            {
                if (i.szemely != szemely) continue;
                bent = i.irany;

                if (i.irany) perc = i.perc;
                else osszesen += i.perc - perc;
            }

            Console.WriteLine();
            Console.WriteLine("8. feladat:");
            if (bent) Console.WriteLine("A(z) " + szemely + ". személy összesen " + osszesen + " percet volt bent, a megfigyelés végén a társalgóban volt.");
            else Console.WriteLine("A(z) " + szemely + ". személy összesen " + osszesen + " percet volt bent, a megfigyelés végén nem volt a társalgóban.");
        }
    }
}
