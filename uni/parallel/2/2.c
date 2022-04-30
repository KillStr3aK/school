/*
            2022
    Parhuzamos Algoritmusok
      Ivacs David, OYFTRQ
*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>

#define ARR_SIZE 10

#define RND_MIN 0
#define RND_MAX 100

int getRandomInt(int, int);
void fillArray(int*, int, bool);
bool haveAlready(const int*, int, int);

int main(void)
{
    srand(time(NULL));

    int Szamok[ARR_SIZE];
    fillArray(Szamok, ARR_SIZE, false);

    printf("Tomb ugyanolyan elemek nelkul:\n");
    for(int i = 0; i < ARR_SIZE; i++)
    {
        printf("%d ", Szamok[i]);
    }

    //                          0.5 valószínûséggel duplikáljon benne néhány elemet!
    fillArray(Szamok, ARR_SIZE, getRandomInt(0, 100) <= 50);

    printf("\n\nTomb amiben mar lehetnek duplikalt elemek:\n");
    for(int i = 0; i < ARR_SIZE; i++)
    {
        printf("%d ", Szamok[i]);
    }

    printf("\n");
	return 0;
}

void fillArray(int* arr, int size, bool canDuplicate)
{
    int randomSzam = 0;
    for(int i = 0; i < ARR_SIZE; i++)
    {
        if(canDuplicate)
        {
            randomSzam = getRandomInt(RND_MIN, RND_MAX);
        } else {
            do {
                randomSzam = getRandomInt(RND_MIN, RND_MAX);
            } while(haveAlready(arr, ARR_SIZE, randomSzam));
        }

        arr[i] = randomSzam;
    }
}

bool haveAlready(const int* arr, int size, int num)
{
    for(int i = 0; i < size; i++)
    {
        if(arr[i] == num)
            return true;
    }

    return false;
}

int getRandomInt(int min, int max)
{
    return (rand() % (max - min) + 1) + min;
}
