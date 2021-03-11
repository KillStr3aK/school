using System;

namespace Book
{
    class Book
    {
        public string Name { get; set; }
        public string Author { get; set; }
        public int Release { get; set; }
        public long Price { get; set; }

        public Book(string name, string author, int release, long price)
        {
            Name = name;
            Author = author;
            Release = release;
            Price = price;
        }

        public Book(string name, string author)
        {
            Name = name;
            Author = author;
            Release = 2021;
            Price = 2500;
        }

        public void IncreasePrice(double percent)
        {
            Price *= (long)(percent / 100.0);
        }

        public override string ToString()
        {
            return $"Name:\t{Name}\nAuthor:\t{Author}\nDate:\t{Release}\nPrice:\t{Price}";
        }
    }
}