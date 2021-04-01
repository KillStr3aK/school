using System;

namespace Szinezheto
{
    class Pont
    {
        public int X { get; private set; }
        public int Y { get; private set; }

        public Pont(int x, int y)
        {
            X = x;
            Y = y;
        }

        public override string ToString()
        {
            return $"{X} {Y}";
        }
    }
}