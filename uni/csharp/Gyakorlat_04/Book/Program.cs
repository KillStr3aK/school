using System;
using System.Collections.Generic;

namespace Book
{
    class Program
    {
        static void Main(string[] args)
        {
            int n = ReadInt("Book amount: ");
            Book[] books = new Book[n];

            for (int i = 0; i < books.Length; i++)
            {
                Console.WriteLine($"{i + 1}. Book");

                Console.Write("Title: ");
                string title = Console.ReadLine();

                Console.Write("Author: ");
                string author = Console.ReadLine();

                int pages = ReadInt("Pages: ");
                books[i] = new Book(title, author, pages);
            }

            LongestBook(books);
            LongestEvenBook(books);
            BookAuthors(books);

            n = ReadIntCheck("Book style amount: ", 1, 10);
            BookStyle[] bookStyles = new BookStyle[n];

            for (int i = 0; i < bookStyles.Length; i++)
            {
                Console.WriteLine($"{i + 1}. Book");

                Console.Write("Title: ");
                string title = Console.ReadLine();

                Console.Write("Author: ");
                string author = Console.ReadLine();

                int pages = ReadInt("Pages: ");

                Console.Write("Style: ");
                string style = Console.ReadLine();
                bookStyles[i] = new BookStyle(title, author, pages, style);
            }

            PrintStyledBooks(bookStyles, "Scifi");
            AveragePriceStyledBooks(bookStyles, "Scifi");
        }

        static void LongestBook(Book[] arr)
        {
            int longest = 0;
            for(int i = 1; i < arr.Length; i++)
            {
                if (arr[i].PageCount > arr[longest].PageCount)
                    longest = i;
            }

            Console.WriteLine(arr[longest]);
        }

        static void LongestEvenBook(Book[] arr)
        {
            int longest = -1;
            for (int i = 1; i < arr.Length; i++)
            {
                if (!arr[i].EvenPage())
                    continue;

                if (longest == -1)
                {
                    longest = i;
                    continue;
                }

                if (arr[i].PageCount > arr[longest].PageCount)
                    longest = i;
            }

            if (longest != -1)
                Console.WriteLine(arr[longest]);
        }

        static void BookAuthors(Book[] arr)
        {
            Dictionary<string, int> Authors = new Dictionary<string, int>();
            foreach(Book i in arr)
            {
                if (!Authors.ContainsKey(i.Author)) Authors.Add(i.Author, 1);
                else Authors[i.Author]++;
            }

            foreach(KeyValuePair<string, int> i in Authors)
            {
                Console.WriteLine($"{i.Key} {i.Value}");
            }
        }

        static void PrintStyledBooks(BookStyle[] bookStyles, string style)
        {
            foreach(BookStyle i in bookStyles)
            {
                if (string.Equals(i.Style, style))
                    Console.WriteLine(i);
            }
        }

        static long AveragePriceStyledBooks(BookStyle[] bookStyles, string style)
        {
            long averagePrice = 0;
            foreach (BookStyle i in bookStyles)
            {
                if(string.Equals(i.Style, style))
                    averagePrice += i.Price;
            }

            return averagePrice / bookStyles.Length;
        }

        static int ReadIntCheck(string msg, int min, int max)
        {
            Console.WriteLine(msg + $"({min} - {max})");

            int num;
            while(!int.TryParse(Console.ReadLine(), out num) || num < min || num > max)
            {
                Console.WriteLine("Invalid input");
            }

            return num;
        }

        static int ReadInt(string msg)
        {
            Console.Write(msg);
            return Convert.ToInt32(Console.ReadLine());
        }
    }
}