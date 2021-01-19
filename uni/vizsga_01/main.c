#include <stdio.h>
#include <stdlib.h>

#define PREV_VAL 200
#define ARR_SIZE 12

void fillArray(int*, int*, int);
void printArray(int*, int);
float arrayAverage(int*, int);
void getMinAndMax(int*, int, int*, int*);

void fillMatrix(int[ARR_SIZE][5], int*, int*, int);
void printMatrix(int[ARR_SIZE][5]);

int main()
{
    int oraAllas[ARR_SIZE] = { 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212};
    int fogyasztas[ARR_SIZE];
    fillArray(oraAllas, fogyasztas, ARR_SIZE);
    printArray(fogyasztas, ARR_SIZE);
    float average = arrayAverage(fogyasztas, ARR_SIZE);
    printf("Fogyasztas atlaga: %.1f\n", average);
    int min = 0;
    int max = 0;
    getMinAndMax(fogyasztas, ARR_SIZE, &min, &max);
    printf("Fogyasztas kulonbsege: %d\n", max - min);

    int matrix[ARR_SIZE][5];
    fillMatrix(matrix, oraAllas, fogyasztas, ARR_SIZE);
    printMatrix(matrix);
    return 0;
}

void fillArray(int* arr, int* dest, int size)
{
    dest[0] = arr[0] - PREV_VAL;
    for(int i = 1; i < size; i++)
    {
        dest[i] = arr[i] - arr[i - 1];
    }
}

void printArray(int* arr, int size)
{
    for(int i = 0; i < size; i++)
    {
        printf("%d. %d %d\n", i + 1, arr[i], arr[i] * 36);
    }
}

float arrayAverage(int* arr, int size)
{
    int sum = 0;
    for(int i = 0; i < size; i++)
    {
        sum += arr[i];
    }

    return (float)sum / size;
}

void getMinAndMax(int* arr, int size, int* min, int* max)
{
    for(int i = 0; i < size; i++)
    {
        if(arr[i] < arr[*min]) *min = i;
        else if(arr[i] > arr[*max]) *max = i;
    }
}

void fillMatrix(int matrix[ARR_SIZE][5], int* ora, int* fogy, int size)
{
    matrix[0][0] = 0;
    matrix[0][1] = PREV_VAL;
    matrix[0][2] = ora[0];
    matrix[0][3] = fogy[0];
    matrix[0][4] = fogy[0] * 36;

    for(int i = 1; i < ARR_SIZE; i++)
    {
        matrix[i][0] = i;
        matrix[i][1] = ora[i - 1];
        matrix[i][2] = ora[i];
        matrix[i][3] = fogy[i];
        matrix[i][4] = fogy[i] * 36;
    }
}

void printMatrix(int matrix[ARR_SIZE][5])
{
    for(int i = 0; i < ARR_SIZE; i++)
    {
        printf("%d. %d %d %d %d\n", matrix[i][0], matrix[i][1], matrix[i][2], matrix[i][3], matrix[i][4]);
    }
}
