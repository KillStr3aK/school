/*
            2022
    Parhuzamos Algoritmusok
      Ivacs David, OYFTRQ
*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define RANDOM_MIN 0
#define RANDOM_MAX 99999999

int getRandomInt(int, int);
void printInteger(int);

int main(void)
{
	srand(time(NULL));
    for(int i = 0; i < 10; i++)
    {
        int n = getRandomInt(RANDOM_MIN, RANDOM_MAX);
        printInteger(n);
        printf("%d\n", n);
    }

	return 0;
}

void printInteger(int n)
{
    int length = 0;
    if (n > 1000000)
        length = 1;
    else if (n > 100000)
        length = 2;
    else if (n > 10000)
        length = 3;
    else if (n > 1000)
        length = 4;
    else if (n > 100)
        length = 5;
    else if (n > 10)
        length = 6;
    else if (n >= 0)
        length = 7;

    for(int i = 0; i < length; i++)
    {
        printf("0");
    }
}

int getRandomInt(int min, int max)
{
    return (rand() % (max - min) + 1) + min;
}
