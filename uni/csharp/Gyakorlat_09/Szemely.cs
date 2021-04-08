using System;

namespace Gyak9
{
    class Szemely
    {
        public string Nev { get; private set; }
        public int Kor { get; private set; }

        public Szemely(string nev, int kor)
        {
            Nev = nev;
            Kor = kor;
        }

        public override string ToString()
        {
            return $"{Nev} {Kor}";
        }
    }
}