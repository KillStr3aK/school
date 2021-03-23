using System;

namespace MyProducts
{
    class Program
    {
        static void Main(string[] args)
        {
            Product product = new Product("Test Product", 1000, 27);
            Console.WriteLine(product);

            Bread bread = new Bread("Bread", 200, 27, 1);
            Console.WriteLine(bread);

            Console.WriteLine(Product.Compare(product, bread));

            Product product2 = new Bread("Product 2", 200, 27, 1);
            Console.WriteLine(product2);

            Bread bread2 = new Bread("Bread 2", 200, 27, 1);
            Console.WriteLine(Bread.Compare((Bread)product2, bread) ? product2 : bread);
        }
    }
}