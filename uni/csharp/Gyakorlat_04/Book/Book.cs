using System;

namespace Book
{
    class Book
    {
        public string Name { get; set; }
        public string Author { get; set; }
        public readonly int Release;
        public long Price { get; set; }
        public int PageCount { get; set; }

        public static string Publisher = "Móra";

        public Book(string name, string author, int release, long price, int pages)
        {
            Name = name;
            Author = author;
            Release = release;
            Price = price;
        }

        public Book(string name, string author, int pages) : this(name, author, DateTime.Now.Year, 2500, pages) { }

        public void IncreasePrice(double percent)
        {
            Price *= (long)(percent / 100.0);
        }

        public bool EvenPage()
        {
            return PageCount % 2 == 0;
        }

        public override string ToString()
        {
            return $"Name:\t{Name}\nAuthor:\t{Author}\nDate:\t{Release}\nPrice:\t{Price}";
        }

        public static Book Longer(Book b1, Book b2)
        {
            return b1.PageCount > b2.PageCount ? b1 : b2;
        }
    }
}