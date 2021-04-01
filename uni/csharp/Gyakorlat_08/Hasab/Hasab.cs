using System;

namespace Testek
{
    abstract class Hasab
    {
        protected int magassag;

        public int Magassag
        {
            get { return magassag; }
        }

        public Hasab(int magassag)
        {
            this.magassag = magassag;
        }

        public abstract double Terulet();

        public double Terfogat()
        {
            return Terulet() * magassag;
        }

        public bool Nagyobb(Hasab h1)
        {
            return Terfogat() > h1.Terfogat();
        }
    }
}