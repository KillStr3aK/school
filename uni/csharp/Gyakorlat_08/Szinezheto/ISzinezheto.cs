using System;

namespace Szinezheto
{
    public enum Szin
    {
        Piros = 0,
        Zold,
        Kek,
        Sarga,
        Lila
    };

    interface ISzinezheto
    {
        Szin Szin { get; set; }
    }
}