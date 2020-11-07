#include <stdio.h>
#include <stdlib.h>

#include <time.h>
#include <stdbool.h>

#define LOWER 1
#define UPPER 95

#define MERET 5

int readInt(int, int);
int getRandomInt(int, int);
bool haveAlready(int[], size_t, int);
void clearBuffer();


int main()
{
    srand(time(NULL));

    int randomSzamok[MERET];
    int bekertSzamok[MERET];
    int randomNumber;
    int i;

    for(i = 0; i < MERET; i++)
    {
        do {
            randomNumber = getRandomInt(LOWER, UPPER);
        } while(haveAlready(randomSzamok, MERET, randomNumber));

        randomSzamok[i] = randomNumber;
    }

    printf("\n");

    for(i = 0; i < MERET; i++)
    {
        do {
            printf("Add meg a(z) %d. szamot: ", i + 1);
            randomNumber = readInt(LOWER, UPPER);
        } while(haveAlready(bekertSzamok, MERET, randomNumber));

        bekertSzamok[i] = randomNumber;
    }

    //int eltalaltSzamok[MERET];
    int talalatok = 0;

    printf("Eltalalt szamok:");
    for(i = 0; i < MERET; i++)
    {
        if(haveAlready(randomSzamok, MERET, bekertSzamok[i]))
        {
            /*eltalaltSzamok[*/talalatok++/*] = bekertSzamok[i]*/;
            printf(" %d", bekertSzamok[i]);
        }
    }

    printf("\nOsszesen: %d", talalatok);

    return 0;
}

int readInt(int min, int max)
{
    int num;
    while(scanf("%d", &num) != 1 || num < min || num > max)
    {
        printf("Hibas adat!\n");
        clearBuffer();
    }

    return num;
}

bool haveAlready(int array[], size_t size, int num)
{
    int i;
    for(i = 0; i < size; i++)
    {
        if(array[i] == num)
            return true;
    }

    return false;
}

int getRandomInt(int min, int max)
{
    return (rand() % (max - min) + 1) + min;
}

void clearBuffer()
{
    char c;
    while((c = getchar()) != '\n');
}
