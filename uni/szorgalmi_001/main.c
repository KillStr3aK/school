#include <stdio.h>
#include <stdlib.h>

#include <time.h>
#include <string.h>

#define ALSO 0
#define FELSO 1

#define MIN 1
#define MAX 100

/*
    Nem a legjobb kivitelezés, ha máskor nekiülnék valószínûleg
    máshogy csinálnám, de nem volt kikötve semmi, szóval gondolom
    elég ha mûködik

    Röviden: A kisebb / nagyobb kérdések után változik az intervallum
    alsó és felsõ határa, tehát elõbb utóbb kikell jöjjön a gondolt szám ( /!\ normális válaszok esetén /!\ )
*/

enum GameState {
    NOT_IN_GAME,
    IN_GAME
};

enum Valasz {
    NEM_EGYENLO,
    NAGYOBB,
    KISEBB,
    EGYENLO
};

void ClearBuffer();
void WaitForValidAnswer(char*);

int main()
{
    srand(time(NULL));

    int Status = IN_GAME;

    do {
        int Tipp = NEM_EGYENLO;
        int Intervallum[2] = {MIN, MAX};
        int Random = 0;

        char FelhasznaloValasz[16] = "nemmehet";

        system("cls");
        printf("Gondolj egy szamra %d-%d kozott es en kitalalom! (A kezdeshez ird be, hogy \"mehet\")\n", MIN, MAX);

        while(scanf("%s", FelhasznaloValasz) != 1 || (strcmp(FelhasznaloValasz, "mehet") != 0))
        {
            printf("A kezdeshez csak ird be, hogy \"mehet\")\n");
            ClearBuffer();
        }

        ClearBuffer();

        do {
            Random = (rand() % (Intervallum[FELSO] - Intervallum[ALSO] + 1) + Intervallum[ALSO]);
            printf("A szam amire gondoltal.. a(z) %d? (igen | nem)\n", Random);

            WaitForValidAnswer(FelhasznaloValasz);

            if(strcmp(FelhasznaloValasz, "nem") == 0)
            {
                if(Random <= MIN || Random >= MAX)
                    continue;

                Tipp = (rand() % 100 + 1) <= 50 ? KISEBB : NAGYOBB; //Veletlenszeruen fogjuk kerdezni, hogy kisebb vagy nagyobb
                printf("A szam %s mint.. %d? (igen | nem)\n", Tipp == KISEBB ? "kisebb" : "nagyobb", Random);

                WaitForValidAnswer(FelhasznaloValasz);

                if(Tipp == KISEBB)
                {
                    if(strcmp(FelhasznaloValasz, "igen") == 0)
                    {
                        Intervallum[FELSO] = --Random;
                    } else if(strcmp(FelhasznaloValasz, "nem") == 0)
                    {
                        Intervallum[ALSO] = ++Random ;
                    }
                } else if(Tipp == NAGYOBB)
                {
                    if(strcmp(FelhasznaloValasz, "igen") == 0)
                    {
                        Intervallum[ALSO] = ++Random;
                    } else if(strcmp(FelhasznaloValasz, "nem") == 0)
                    {
                        Intervallum[FELSO] = --Random ;
                    }
                }

                if(Intervallum[ALSO] >= Intervallum[FELSO])
                    Tipp = EGYENLO;
            } else
            {
                Tipp = EGYENLO;
            }
        } while (Tipp != EGYENLO);

        printf("\nKitalaltam! A szam amire gondoltal a(z) %d volt!\n\n", Random);
        printf("Szeretned folytatni a jatekot? (igen | nem)\n");

        WaitForValidAnswer(FelhasznaloValasz);
        Status = strcmp(FelhasznaloValasz, "nem") == 0 ? NOT_IN_GAME : IN_GAME;
    } while (Status/* == IN_GAME*/);

    printf("\nA jatek veget ert.\n");
    return 0;
}

void ClearBuffer()
{
    char c;
    while((c = getchar()) != '\n');
}

void WaitForValidAnswer(char* str)
{
    while(scanf("%s", str) != 1 || (!(strcmp(str, "nem") == 0) && !(strcmp(str, "igen") == 0)))
    {
        printf("Erre a kerdesre az \"igen\" vagy \"nem\" lehetosegekkel valaszolj!\n");
        ClearBuffer();
    }

    ClearBuffer();
}
