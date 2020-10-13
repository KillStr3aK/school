#include <stdio.h>
#include <stdlib.h>

#include <time.h>

enum GameState {
    NOT_IN_GAME,
    IN_GAME
};

void ClearBuffer();

int main()
{
    srand(time(NULL));

    int Status = IN_GAME;

    do {
        int random = rand() % 100;
        int tipp = 0;

        system("cls");
        printf("Gondoltam egy szamra 1-100 kozott. Talald ki!\n");
        do {
            while(scanf("%d", &tipp) != 1)
            {
                printf("Hibas adat! Probald ujra.\n");
                ClearBuffer();
            }

            if(tipp < 1 || tipp > 100)
            {
                printf("A szam 1-100 kozott van, probald ujra!\n");
                continue;
            }

            if(tipp < random) printf("A szam amire gondoltam ennel nagyobb!\n");
            else if(tipp > random) printf("A szam amire gondoltam ennel kisebb!\n");
        } while (tipp != random);

        printf("Eltalaltad! A szam a(z) %d volt!\n", random);
        printf("Szeretned folytatni a jatekot? (0 nem | barmilyen masik szam igen)\n");
        while(scanf("%d", &Status) != 1)
        {
            printf("Hibas adat!\nHa nem akarod folytatni a jatekot irj be 1db \"0\"-t, ha folytatni szeretned akkor egy nem \"0\" szamot!\n");
            ClearBuffer();
        }
    } while (Status/* == IN_GAME*/);

    printf("A jatek veget ert.\n");
    return 0;
}

void ClearBuffer()
{
    char c;
    while((c = getchar()) != '\n');
}
