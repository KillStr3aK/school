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

        static int ReadInt(string msg)
        {
            Console.Write(msg);
            return Convert.ToInt32(Console.ReadLine());
        }
    }
}