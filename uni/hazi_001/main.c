#include <stdio.h>
#include <stdlib.h>

#include <stdbool.h>

//7. Keresse meg és irassa ki az elsõ N db prímszámot. N értékének beolvasása ellenõrzéssel történjen.
int main()
{
    int n;

    int i; //(nem kaptam hibát akkor amikor a ciklus elején deklaráltam, de inkább megcsináltam igy)
    int k;

    char c;

    printf("Adj meg egy kettonel nagyobb szamot: ");
    while(scanf("%d", &n) != 1 || n < 2) //Nem megyünk tovább amíg nem jó az adat
    {
        printf("\nHibas adat! Csak egy kettonel nagyobb szamot varok\n");
        while((c = getchar()) != '\n');
    }

    bool prim[n]; //Remélem jó így, az index maga a számot fogja jelenteni

    for(i = 0; i < n; i++)
    {
        prim[i] = true; //Alapból azt feltételezzük hogy mindegyik szám prím
    }

    for(i = 2; i < n; i++) //A nem prím számokat átállítjuk hamisra
    {
        for(k = 2; k < (n / i); k++)
        {
            prim[i*k] = false; //Egy szám összes többszöröse sem lehet prím
        }
    }

    printf("Primszamok 1-%i kozott:\n", n);
    for(i = 2; i < n; i++)
    {
        if(!prim[i])
            continue;

        printf("%i\n", i); //Az igazon maradt indexek a prím számok
    }

    return 0;
}
