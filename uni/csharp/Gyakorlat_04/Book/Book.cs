using System;

namespace Book
{
    class Book
    {
        public string Name { get; set; }
        public string Author { get; set; }
        public int Release { get; set; }
        public long Price { get; set; }

        public void IncreasePrice(double percent)
        {
            Price *= (long)(percent / 100.0);
        }

        public string Get()
        {
            return $"Name:\t{Name}\nAuthor:\t{Author}\nDate:\t{Release}\nPrice:\t{Price}";
        }
    }
}