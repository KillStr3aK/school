/*
            2022
    Parhuzamos Algoritmusok
      Ivacs David, OYFTRQ
*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define ARR_SIZE 10

#define RND_MIN 0
#define RND_MAX 100

int getRandomInt(int, int);

int getArrSum(int*, int);
int getArrSumRecursive(int*, int);

int getArrMin(int*, int);
int getArrMinRecursive(int*, int);

int getArrMax(int*, int);
int getArrMaxRecursive(int*, int);

int main(void)
{
    srand(time(NULL));

    int Szamok[ARR_SIZE];
    for(int i = 0; i < ARR_SIZE; i++)
    {
        Szamok[i] = getRandomInt(RND_MIN, RND_MAX);
    }

    printf("Generalt szamok: \n");
    for(int i = 0; i < ARR_SIZE; i++)
    {
        printf("%d ", Szamok[i]);
    }

    printf("\n");

    clock_t begin = clock();
    int sum = getArrSum(Szamok, ARR_SIZE);
    int min = getArrMin(Szamok, ARR_SIZE);
    int max = getArrMax(Szamok, ARR_SIZE);
    clock_t end = clock();

    double elapsedTime = (double)(end - begin) / CLOCKS_PER_SEC;
    printf("Sum: %d\nMin: %d\nMax: %d\nEltelt ido: %.2f\n", sum, min, max, elapsedTime);

    clock_t beginrecursive = clock();
    int sumrec = getArrSumRecursive(Szamok, ARR_SIZE - 1);
    int minrec = getArrMinRecursive(Szamok, ARR_SIZE - 1);
    int maxrec = getArrMaxRecursive(Szamok, ARR_SIZE - 1);
    clock_t endrecursive = clock();

    elapsedTime = (double)(endrecursive - beginrecursive) / CLOCKS_PER_SEC;
    printf("\n/!\\ Rekurziv /!\\ \nSum: %d\nMin: %d\nMax: %d\nEltelt ido: %.2f\n", sumrec, minrec, maxrec, elapsedTime);

	return 0;
}

int getArrMin(int* arr, int size)
{
    int min = arr[0];
    for(int i = 1; i < size; i++)
    {
        if(arr[i] < min)
            min = arr[i];
    }

    return min;
}

int getArrMinRecursive(int* arr, int n)
{
    int min = arr[n];
    if(n > 0)
    {
        min = getArrMinRecursive(arr, n - 1);
        if(min > arr[n])
            return arr[n];
        else
            return min;
    } else return arr[0];
}

int getArrMax(int* arr, int size)
{
    int max = arr[0];
    for(int i = 1; i < size; i++)
    {
        if(arr[i] > max)
            max = arr[i];
    }

    return max;
}

int getArrMaxRecursive(int* arr, int n)
{
    int max = arr[n];
    if(n > 0)
    {
        max = getArrMaxRecursive(arr, n - 1);
        if(max < arr[n])
            return arr[n];
        else
            return max;
    } else return arr[0];
}

int getArrSum(int* arr, int size)
{
    int sum = 0;
    for(int i = 0; i < size; i++)
    {
        sum += arr[i];
    }

    return sum;
}

int getArrSumRecursive(int* arr, int n)
{
    int sum = 0;
    if(n != 0)
    {
        sum += getArrSumRecursive(arr, n - 1) + arr[n];
        return sum;
    } else return arr[0];
}

int getRandomInt(int min, int max)
{
    return (rand() % (max - min) + 1) + min;
}
