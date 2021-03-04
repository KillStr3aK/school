using System;

namespace Person
{
    class Person
    {
        public string Name { get; set; }
        public int Weight { get; set; }
        public int Height { get; set; }

        public string Get()
        {
            return $"Név: {Name} Súly: {Weight} Magasság: {Height} TTI: {TTIString()}";
        }

        public double TTI() 
        {
            return Weight / Height * Height;
        }

        public string TTIString()
        {
            double tti = TTI();
            if (tti < 18.5) return "sovány";
            else if (tti > 25.0) return "kövér";
            return "normál";
        }
    }
}