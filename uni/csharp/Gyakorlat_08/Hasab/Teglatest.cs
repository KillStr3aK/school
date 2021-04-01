using System;

namespace Testek
{
    class Teglatest : Hasab
    {
        private double a;
        private double b;

        public double A
        {
            get { return a; }
        }

        public double B
        {
            get { return b; }
        }

        public Teglatest(double a, double b, int magassag) : base(magassag)
        {
            this.a = a;
            this.b = b;
        }

        public override double Terulet()
        {
            return A * B;
        }

        public override string ToString()
        {
            return $"{A} {B} {Terfogat()}";
        }
    }
}