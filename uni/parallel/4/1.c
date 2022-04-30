/*
            2022
    Parhuzamos Algoritmusok
      Ivacs David, OYFTRQ
*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include <omp.h>

#define RND_MAX 1000
#define ARR_SIZE 10

double seqMulti(double*, int);
double openMulti(double*, int);

double getRandomDouble(int);

int main(void)
{
    srand(time(NULL));

    double arr[ARR_SIZE];

    printf("Tomb elemei: \n");
    for(int i = 0; i < ARR_SIZE; i++)
    {
        arr[i] = getRandomDouble(RND_MAX);
        printf("%.2f ", arr[i]);
    }

    printf("\n");

    double seqresult = seqMulti(arr, ARR_SIZE);
    double opmresult = openMulti(arr, ARR_SIZE);

    printf("seqresult = %.2f\n", seqresult);
    printf("opmresult = %.2f\n", opmresult);
    return 0;
}

double getRandomDouble(int max)
{
    return (double)rand() / (double)max;
}

double seqMulti(double* arr, int size)
{
    double result = 1;
    for(int i = 0; i < size; i++)
    {
        result *= arr[i];
    }

    return result;
}

double openMulti(double* arr, int size)
{
    double result = 1;

    #pragma omp parallel for
    for(int i = 0; i < size; i++)
    {
        result *= arr[i];
    }

    return result;
}
