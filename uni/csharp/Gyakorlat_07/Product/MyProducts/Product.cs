using System;

namespace MyProducts
{
    class Product
    {
        public string Name { get; private set; }
        public int Price { get; private set; }
        public int Tax { get; private set; }

        public Product(string name, int price, int tax)
        {
            Name = name;
            Price = price;
            Tax = tax;
        }

        public float GrossPrice()
        {
            return Price + Price * (Tax / 100.0f);
        }

        public void IncreasePrice(int percent)
        {
            Price *= (int)(percent / 100.0);
        }

        public static int Compare(Product p1, Product p2)
        {
            if (p1.Price > p2.Price) return 1;
            else if (p1.Price == p2.Price) return 0;
            else return -1;
        }

        public override string ToString()
        {
            return $"{Name} {GrossPrice()}";
        }
    }
}