using Microsoft.VisualBasic.CompilerServices;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection.PortableExecutable;

namespace cegesauto
{
    class Program
    {
        class Auto
        {
            public int Nap;
            public string Ido;
            public string Rendszam;
            public int Szemely;
            public int KmOra;
            public bool Hajtas;

            public Auto() { }
        }

        static List<Auto> Autok = new List<Auto>();

        static void Main(string[] args)
        {
            Feladat1();
            Feladat2();
            Feladat3();
            Feladat4();
            Feladat5();
            Feladat6();
            Feladat7();
        }

        static void Feladat1()
        {
            FileStream fs = File.Open("C:\\Minden\\visual studio\\erettsegi\\cegesautok\\autok.txt", FileMode.Open);
            StreamReader sr = new StreamReader(fs);

            while(!sr.EndOfStream)
            {
                string[] darabok = sr.ReadLine().Split(' ');
                Autok.Add(new Auto
                {
                    Nap = Convert.ToInt32(darabok[0]),
                    Ido = darabok[1],
                    Rendszam = darabok[2],
                    Szemely = Convert.ToInt32(darabok[3]),
                    KmOra = Convert.ToInt32(darabok[4]),
                    Hajtas = Convert.ToBoolean(Convert.ToInt32(darabok[5])),
                });
            }

            sr.Close();
            fs.Close();
        }
        static void Feladat2()
        {
            Console.WriteLine("2. feladat:");
            Auto auto = Autok.FindLast(x => !x.Hajtas);
            Console.WriteLine($"{auto.Nap}. nap rendszám: {auto.Rendszam}");
        }
        static void Feladat3()
        {
            Console.WriteLine("3. feladat:");
            Console.WriteLine("Nap: ");
            int nap = Convert.ToInt32(Console.ReadLine());

            Console.WriteLine($"Forgalom a(z) {nap}. napon:");
            foreach(Auto i in Autok)
            {
                if (i.Nap != nap) continue;
                string irany = i.Hajtas ? "be" : "ki";
                Console.WriteLine($"{i.Ido} {i.Rendszam} {i.Szemely} {irany}");
            }
        }
        static void Feladat4()
        {
            Console.WriteLine("4. feladat:");

            int darab = 0;
            bool[] visszahoztak = new bool[10];
            foreach(Auto i in Autok)
            {
                visszahoztak[AutoFromRendszam(i.Rendszam)] = i.Hajtas;
            }

            foreach(bool i in visszahoztak)
            {
                if (!i)
                    ++darab;
            }    

            Console.WriteLine($"A hónap végén {darab} autót nem hoztak vissza.");
        }
        static void Feladat5()
        {
            Console.WriteLine("5. feladat:");
            int[] aautokki = new int[10];
            int[] aautokbe = new int[10];

            for (int i = 0; i < 10; i++)
                aautokki[i] = 0;

            foreach(Auto auto in Autok)
            {
                int szam = AutoFromRendszam(auto.Rendszam);
                if(!auto.Hajtas && aautokki[szam] == 0)
                    aautokki[szam] = auto.KmOra;

                if(auto.Hajtas)
                    aautokbe[szam] = auto.KmOra;
            }

            for (int i = 0; i < 10; i++)
                Console.WriteLine($"CEG30{i} {aautokbe[i] - aautokki[i]} km");
        }
        static void Feladat6()
        {
            List<Auto> rendezettautok = Autok.OrderBy(x => x.Rendszam).ToList();
            int km = 0;
            int szemely = 0;
            
            for(int i = 1; i < rendezettautok.Count; i++)
            {
                if(rendezettautok[i].Rendszam == rendezettautok[i - 1].Rendszam && rendezettautok[i].Hajtas)
                {
                    if(km < (rendezettautok[i].KmOra - rendezettautok[i - 1].KmOra))
                    {
                        km = (rendezettautok[i].KmOra - rendezettautok[i - 1].KmOra);
                        szemely = rendezettautok[i].Szemely;
                    }
                }
            }

            Console.WriteLine($"Leghosszabb út: {km} km, személy: {szemely}");
        }
        static void Feladat7()
        {
            for(int i = 0; i < 10; i++)
            {
                FileStream fs = File.Open($"CEG30{i}_menetlevel.txt", FileMode.Append);
                StreamWriter sw = new StreamWriter(fs);
                foreach (Auto auto in Autok)
                {
                    int szam = AutoFromRendszam(auto.Rendszam);
                    if(szam == i)
                    {
                        if(!auto.Hajtas)
                            sw.Write($"{auto.Szemely}\t{auto.Nap}. {auto.Ido}\t{auto.KmOra} km");
                        
                        if(auto.Hajtas)
                            sw.WriteLine($"\t{auto.Nap}. {auto.Ido}\t{auto.KmOra} km");
                    }
                }

                sw.Close();
                fs.Close();
            }
        }

        static int AutoFromRendszam(string rendszam)
        {
            return Convert.ToInt32(Convert.ToString(rendszam[5]));
        }
    }
}