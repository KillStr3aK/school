using System;

namespace Gyak9
{
    enum Beosztas
    {
        PROF,
        OKTATO,
        ADMIN
    };

    class EgyetemiAlkalmazott : Alkalmazott, IComparable<EgyetemiAlkalmazott>
    {
        public static int Alapber = 500000;
        public Beosztas Beosztas { get; private set; }

        public EgyetemiAlkalmazott(string nev, int kor, string munkahely, Beosztas beosztas) : base(nev, kor, munkahely, 0)
        {
            switch(beosztas)
            {
                case Beosztas.PROF: Fizetes = Alapber;  break;
                case Beosztas.OKTATO: Fizetes = Alapber * 50 / 100; break;
                case Beosztas.ADMIN: Fizetes = Alapber * 30 / 100; break;
            }

            Beosztas = beosztas;
        }

        public int CompareTo(EgyetemiAlkalmazott ea)
        {
            return Kor - ea.Kor;
        }

        public override string ToString()
        {
            return base.ToString() + $" {Beosztas}";
        }
    }
}