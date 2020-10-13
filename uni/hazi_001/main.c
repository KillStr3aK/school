#include <stdio.h>
#include <stdlib.h>

#include <stdbool.h>

//7. Keresse meg �s irassa ki az els� N db pr�msz�mot. N �rt�k�nek beolvas�sa ellen�rz�ssel t�rt�njen.
int main()
{
    int n;

    int i; //(nem kaptam hib�t akkor amikor a ciklus elej�n deklar�ltam, de ink�bb megcsin�ltam igy)
    int k;

    char c;

    printf("Adj meg egy kettonel nagyobb szamot: ");
    while(scanf("%d", &n) != 1 || n < 2) //Nem megy�nk tov�bb am�g nem j� az adat
    {
        printf("\nHibas adat! Csak egy kettonel nagyobb szamot varok\n");
        while((c = getchar()) != '\n');
    }

    bool prim[n]; //Rem�lem j� �gy, az index maga a sz�mot fogja jelenteni

    for(i = 0; i < n; i++)
    {
        prim[i] = true; //Alapb�l azt felt�telezz�k hogy mindegyik sz�m pr�m
    }

    for(i = 2; i < n; i++) //A nem pr�m sz�mokat �t�ll�tjuk hamisra
    {
        for(k = 2; k < (n / i); k++)
        {
            prim[i*k] = false; //Egy sz�m �sszes t�bbsz�r�se sem lehet pr�m
        }
    }

    printf("Primszamok 1-%i kozott:\n", n);
    for(i = 2; i < n; i++)
    {
        if(!prim[i])
            continue;

        printf("%i\n", i); //Az igazon maradt indexek a pr�m sz�mok
    }

    return 0;
}
