using System;
using Testek;

namespace HasabTest
{
    class HasabTest
    {
        private Hasab[] Hasabok;

        public HasabTest(int darab)
        {
            Hasabok = new Hasab[darab];
        }

        public void Set(int index, Hasab h)
        {
            Hasabok[index] = h;
        }

        public Hasab Get(int index)
        {
            return Hasabok[index];
        }

        public int NullDarabszam()
        {
            int db = 0;

            foreach(Hasab i in Hasabok)
            {
                if (i != null)
                    ++db;
            }

            return db;
        }

        public int Darabszam()
        {
            return Hasabok.Length;
        }

        public int HengerDarabszam()
        {
            int db = 0;
            foreach (Hasab i in Hasabok)
            {
                if (i is Henger)
                    ++db;
            }

            return db;
        }

        public double AtlagTerfogat()
        {
            double terfogat = 0;

            foreach (Hasab i in Hasabok)
            {
                if (i == null)
                    continue;

                terfogat += i.Terfogat();
            }

            return terfogat / NullDarabszam();
        }
    }
}