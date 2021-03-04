using System;

namespace Book
{
    class Program
    {
        static void Main(string[] args)
        {
            Book book = new Book
            {
                Name = "Book #1",
                Author = "Author #1",
                Release = 2021,
                Price = 1000
            };

            Console.WriteLine(book.Get());
        }
    }
}