/*
            2022
    Parhuzamos Algoritmusok
      Ivacs David, OYFTRQ
*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define RANDOM_MIN 500
#define RANDOM_MAX 1000

#define RANDOM_MIN_FL 500.0
#define RANDOM_MAX_FL 1000.0

int getRandomInt(int, int);
double getRandomDouble(double, double);

int main(void)
{
	srand(time(NULL));
    for(int i = 0; i < 3; i++)
    {
        printf("Egesz szam: %d\n", getRandomInt(RANDOM_MIN, RANDOM_MAX));
        printf("Lebegopontos szam: %.2f\n", getRandomDouble(RANDOM_MIN_FL, RANDOM_MAX_FL));
    }

	return 0;
}

int getRandomInt(int min, int max)
{
    return (rand() % (max - min) + 1) + min;
}

double getRandomDouble(double min, double max)
{
    return ((double)rand() / (max - min) + 1) + min;
}

