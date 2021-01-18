#include <stdio.h>
#include <stdlib.h>

#include <string.h>

#define MIN 280
#define MAX 285
#define ARR_SIZE 7

void feladat3(float*, float*, int);
void feladat4(float*, int);
void feladat5(float*, int);
void feladat7(float*, float*, int);

float convertToCelsius(float);
void floatArrToString(char*, float*, int);

float readFloat(int, int);
void clearBuffer();

int main()
{
    float averageTemp[ARR_SIZE];

    for(int i = 0; i < ARR_SIZE; i++)
    {
        printf("Add meg a(z) %d. napi homersekletet kelvinben:\n", i + 1);
        *(averageTemp + i) = readFloat(MIN, MAX);
    }

    float* averageCelsius = (float*)malloc(sizeof(float) * ARR_SIZE);
    feladat3(averageTemp, averageCelsius, ARR_SIZE);
    feladat4(averageCelsius, ARR_SIZE);
    feladat5(averageCelsius, ARR_SIZE);
    feladat7(averageTemp, averageCelsius, ARR_SIZE);
    free(averageCelsius);
    return 0;
}

void feladat3(float* original, float* arr, int size)
{
    for(int i = 0; i < size; i++)
    {
        *(arr + i) = convertToCelsius(*(original + i));
    }
}

void feladat4(float* arr, int size)
{
    printf("Add meg az intervallum also hatarat kelvinben:\n");
    float also = convertToCelsius(readFloat(MIN - 1, MAX + 1)); //azért +-1 mert nyilt intervallum, a readFloat meg zárt intervallumban olvas

    printf("Add meg az intervallum felso hatarat kelvinben:\n");
    float felso = convertToCelsius(readFloat(also - 1, MAX + 1));

    printf("---------------------\n");
    for(int i = 0; i < size; i++)
    {
        if(*(arr + i) > also && *(arr + i) < felso)
            printf("%.2f\n", *(arr + i));
    }
    printf("---------------------\n");
}

void feladat5(float* arr, int size)
{
    int min = 0;
    int secondMin = 0;

    for(int i = 1; i < size; i++)
    {
        if(*(arr + i) < *(arr + min))
        {
            secondMin = min;
            min = i;
        }
    }

    printf("A heti minimum hoingas: %.2fC\n", *(arr + secondMin) - *(arr + min));
}

void feladat7(float* arr, float* arr2, int size)
{
    char* charChain = (char*)malloc(size);

    strcpy(charChain, "");
    floatArrToString(charChain, arr, ARR_SIZE);
    printf("KELVIN: \t%s\n", charChain);

    strcpy(charChain, "");
    floatArrToString(charChain, arr2, ARR_SIZE);
    printf("CELSIUS: \t%s\n", charChain);
    free(charChain);
}

void floatArrToString(char* dest, float* arr, int size)
{
    char* temp = (char*)malloc(size);
    for(int i = 0; i < size; i++)
    {
        strcpy(temp, "");
        sprintf(temp, "%.1f;", *(arr + i));
        strcat(dest, temp);
    }

    free(temp);
}

float convertToCelsius(float k)
{
    return k - 273.15f;
}

float readFloat(int min, int max)
{
    float num;
    while(scanf("%f", &num) != 1 || num <= min || num >= max)
    {
        printf("Ervenytelen bemenet!\n");
        clearBuffer();
    }

    return num;
}

void clearBuffer()
{
    while(getchar() != '\n');
}
