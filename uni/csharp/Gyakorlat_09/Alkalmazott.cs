using System;

namespace Gyak9
{
    class Alkalmazott : Szemely
    {
        public string Munkahely { get; private set; }
        public int Fizetes { get; set; }

        public Alkalmazott(string nev, int kor, string munkahely, int fizetes) : base(nev, kor)
        {
            Munkahely = munkahely;
            Fizetes = fizetes;
        }

        public override string ToString()
        {
            return base.ToString() + $" {Munkahely} {Fizetes}";
        }
    }
}