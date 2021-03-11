using System;

namespace Rectangle
{
    class Rectangle
    {
        int Height { get; set; } // A
        int Width { get; set; } // B

        public Rectangle() { }

        public Rectangle(int size)
        {
            Height = Width = size;
        }

        public Rectangle(int height, int width)
        {
            Height = height;
            Width = width;
        }

        public bool SameSize(Rectangle rec)
        {
            return Height == rec.Height && Width == rec.Width;
        }

        public bool HigherArea(Rectangle rec)
        {
            return rec.Area() < Area();
        }

        public void SetSize(int height, int width)
        {
            Height = height;
            Width = width;
        }

        public void SetSquareSize(int size)
        {
            Height = Width = size;
        }

        public int Area()
        {
            return Height * Width;
        }

        public override string ToString()
        {
            return $"Height: {Height}, Width: {Width}, Area: {Area()}";
        }
    }
}