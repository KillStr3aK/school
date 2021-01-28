//feladat: https://cdn.discordapp.com/attachments/322034844412542978/800112186453262406/received_1344644019232424.webp
#include <stdio.h>
#include <stdlib.h>

float convertToKelvin(float);

int readInt();
int readIntHigherThan(int);
float getMin(float*, int);
float getMax(float*, int);

float getAverage(float*, int);

void writeToFile(float*, int);
void clearBuffer();

void feladat2(float*, float*, int);
void feladat3(float*, int);
void feladat4(float*, int);
void feladat6(float*, int);

int main()
{
    float averageTemp[7] = { 10.1f, 13.2f, 11.0f, 12.3f, 14.0f, 13.5f, 13.3f };
    float averageTempInKelvin[7];

    feladat2(averageTempInKelvin, averageTemp, 7);
    feladat3(averageTempInKelvin, 7);
    feladat4(averageTempInKelvin, 7);
    writeToFile(averageTempInKelvin, 7); //feladat5();
    feladat6(averageTempInKelvin, 7);
    return 0;
}

void feladat2(float* arr, float* arr2, int size)
{
    for(int i = 0; i < 7; i++)
    {
        arr[i] = convertToKelvin(arr2[i]);
    }
}

void feladat3(float* arr, int size)
{
    int also = readInt();
    int felso = readIntHigherThan(also);

    for(int i = 0; i < 7; i++)
    {
        if(arr[i] >= also && arr[i] <= felso)
            printf("%.2f\n", arr[i]);
    }
}

void feladat4(float* arr, int size)
{
    float max = getMax(arr, size);
    float min = getMin(arr, size);
    printf("Hoingas: %.2f - %.2f = %.2f", max, min, max - min);
}

void feladat6(float* arr, int size)
{
    float average = getAverage(arr, size);
    for(int i = 0; i < size; i++)
    {
        if(arr[i] > average)
            printf("%d\n", i);
    }
}

int readInt()
{
    int num;
    while(scanf("%d", &num) != 1)
    {
        printf("Hibas adat!\n");
        clearBuffer();
    }

    return num;
}

int readIntHigherThan(int min)
{
    int num;
    while(scanf("%d", &num) != 1 || num < min)
    {
        printf("Hibas adat!\n");
        clearBuffer();
    }

    return num;
}

float getAverage(float* arr, int size)
{
    float sum = 0.0f;
    for(int i = 0; i < size; i++)
    {
        sum += arr[i];
    }

    return sum / size;
}

float getMin(float* arr, int size)
{
    int min = 0;
    for(int i = 0; i < size; i++)
    {
        if(arr[i] < arr[min])
            min = i;
    }

    return arr[min];
}

float getMax(float* arr, int size)
{
    int max = 0;
    for(int i = 0; i < size; i++)
    {
        if(arr[i] > arr[max])
            max = i;
    }

    return arr[max];
}

float convertToKelvin(float v)
{
    return v += 273.15;
}

void writeToFile(float* arr, int size)
{
    FILE* file = fopen("adat.txt", "wt");
    if(file == NULL)
    {
        printf("Unable to open file \"adat.txt\"!");
    }

    for(int i = 0; i < size; i++)
    {
        fprintf(file, "%.2f K\n", arr[i]);
    }

    fclose(file);
}

void clearBuffer()
{
    while(getchar() != '\n');
}
