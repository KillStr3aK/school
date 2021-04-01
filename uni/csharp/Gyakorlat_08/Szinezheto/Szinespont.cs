using System;

namespace Szinezheto
{
    class Szinespont : Pont, ISzinezheto
    {
        public Szin Szin { get; set; }

        public Szinespont() : base(0, 0)
        {
            Szin = Szin.Piros;
        }

        public Szinespont(Szin szin) : base (0, 0)
        {
            Szin = szin;
        }

        public Szinespont(int x, int y, Szin szin) : base(x, y)
        {
            Szin = szin;
        }

        public override string ToString()
        {
            return base.ToString() + " " + Szin;
        }
    }
}