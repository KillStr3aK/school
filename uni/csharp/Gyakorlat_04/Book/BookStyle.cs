using System;

namespace Book
{
    class BookStyle : Book
    {
        public string Style;

        public BookStyle(string name, string author, int pages, string style) : base(name, author, pages)
        {
            Style = style;
        }

        public override string ToString()
        {
            return base.ToString() + " " + Style;
        }
    }
}