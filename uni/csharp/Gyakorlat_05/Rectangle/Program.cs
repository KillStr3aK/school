using System;

namespace Rectangle
{
    class Program
    {
        static void Main(string[] args)
        {
            Feladat1();
            Feladat2();
        }

        static void Feladat1()
        {
            Console.WriteLine("Feladat 1");
            Rectangle a = new Rectangle(5, 10);
            Rectangle b = new Rectangle(10, 5);
            ref Rectangle c = ref a;

            Console.WriteLine(a);
            Console.WriteLine(b);
            Console.WriteLine(c);

            a.SetSize(10, 5);
            Console.WriteLine(a);
            Console.WriteLine(b);
            Console.WriteLine(c);

            Console.WriteLine(a.SameSize(b));
        }

        static void Feladat2()
        {
            Console.WriteLine("Feladat 2");
            Random random = new Random();
            Rectangle[] rectangles = new Rectangle[10];

            for(int i = 0; i < rectangles.Length; i++)
            {
                rectangles[i] = new Rectangle(random.Next(2, 10), random.Next(2, 10));
            }

            PrintArray(rectangles);
            Console.WriteLine($"Smallest rectangle: {GetSmallestRec(rectangles)}");

            int height = ReadInt("Rectangle height:");
            int width = ReadInt("Rectangle width:");
            Rectangle rectangle = new Rectangle(height, width);
            Console.WriteLine("Higher count: " + HigherRectangleCount(rectangles, rectangle));

            int sameIndex = SameSizeIndex(rectangles, rectangle);
            Console.WriteLine(sameIndex == -1 ? "Nincs egyező" : $"Same size index: {sameIndex}");
        }

        static void PrintArray(Rectangle[] recs)
        {
            foreach(Rectangle i in recs)
            {
                Console.WriteLine(i);
            }
        }

        static Rectangle GetSmallestRec(Rectangle[] recs)
        {
            int index = 0;
            for(int i = 1; i < recs.Length; i++)
            {
                if (!recs[i].HigherArea(recs[index]))
                    index = i;
            }

            return recs[index];
        }

        static int HigherRectangleCount(Rectangle[] recs, Rectangle rec)
        {
            int count = 0;
            foreach(Rectangle i in recs)
            {
                if (i.HigherArea(rec))
                    ++count;
            }

            return count;
        }

        static int SameSizeIndex(Rectangle[] recs, Rectangle rec)
        {
            for(int i = 0; i < recs.Length; i++)
            {
                if (recs[i].SameSize(rec))
                    return i;
            }

            return -1;
        }

        static int ReadInt(string msg)
        {
            Console.WriteLine(msg);
            return Convert.ToInt32(Console.ReadLine());
        }
    }
}