#include <stdio.h>
#include <stdlib.h>

int main()
{
    int vizsgaJegy[6];

    int i;
    char c;
    for(i = 0; i < 6; i++)
    {
        printf("Add meg a(z) %d. vizsgad eredmenyet:\n", i + 1);
        while((scanf("%d", &vizsgaJegy[i]) != 1) || vizsgaJegy[i] < 1 || vizsgaJegy[i] > 5)
        {
            printf("Hibas adat, probald ujra megadni a(z) %d. vizsgad eredmenyet:\n", i + 1);
            while((c = getchar()) != '\n');
        }
    }

    double atlag = 0;
    for(i = 0; i < 6; i++)
        atlag += vizsgaJegy[i];

    atlag /= 6;

    int osztondij = 15;

    if(atlag < 3.6) osztondij = 0;
    else if(atlag < 4.1) osztondij = 5;
    else if(atlag < 4.6) osztondij = 10;

    printf("\nA kovetkezo felevi osztondijad %deFt/ho", osztondij);
    return 0;
}
