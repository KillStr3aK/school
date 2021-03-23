using System;

namespace MyProducts
{
    class Bread : Product
    {
        private double Amount;

        public Bread(string name, int price, int tax, double amount) : base(name, price, tax)
        {
            Amount = amount;
        }

        public static bool Compare(Bread b1, Bread b2)
        {
            return (b1.Price / b1.Amount) > (b2.Price / b2.Amount);
        }

        public double GetAmount()
        {
            return Amount;
        }

        public override string ToString()
        {
            return base.ToString() + $" {Price / Amount}";
        }
    }
}