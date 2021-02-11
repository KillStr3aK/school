using System;

namespace CalcPI
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine($"PI = {Math.PI}");

            /* Wallis */
            double PI = 1.0;
            int Iterations = 100000;
            int Count = Iterations / 2;

            for (int i = 1; i <= Count; i++)
            {
                PI *= i * 2.0 / (2 * i - 1);
                PI *= i * 2.0 / (2 * i + 1);
            }

            Console.WriteLine();
            Console.WriteLine($"PI / 2 = {PI}");
            Console.WriteLine($"PI = {PI * 2, 6:G5}");

            /* Leibinz */
            PI = 0.0;
            Count *= 4;
            int Sign = 1;

            for (int i = 1; i <= Count; i += 2)
            {
                PI += Sign * 1.0 / i;
                Sign *= -1;
            }

            Console.WriteLine();
            Console.WriteLine($"PI / 4 = {PI}");
            Console.WriteLine($"PI = {PI * 4, 6:G5}");
        }
    }
}