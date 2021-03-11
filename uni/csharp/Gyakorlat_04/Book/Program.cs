using System;

namespace Book
{
    class Program
    {
        static void Main(string[] args)
        {
            Book book = new Book("Book #1", "Author #1", 2021, 1000);
            Console.WriteLine(book);
        }
    }
}