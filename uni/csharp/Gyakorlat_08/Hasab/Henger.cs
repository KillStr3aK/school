using System;

namespace Testek
{
    class Henger : Hasab
    {
        private double sugar;

        public double Sugar
        {
            get { return Sugar; }
        }

        public Henger(double sugar, int magassag) : base(magassag)
        {
            this.sugar = sugar;
        }

        public override double Terulet()
        {
            return sugar * sugar * Math.PI;
        }

        public override string ToString()
        {
            return $"{sugar} {Terfogat()}";
        }
    }
}