//feladat: https://cdn.discordapp.com/attachments/322034844412542978/800491156525940766/unknown.png
#include <stdio.h>
#include <stdlib.h>

#define SIZE 5
#define MAX 40
#define MIN 15

float calcTTI(float, float);

void feladat3(float*, int);
void feladat4(float*, int);
int feladat6(float*, int, int, int);

int readInt(int, int);

void clearBuffer();

int main()
{
    float Heights[SIZE] = { 1.20f, 1.16f, 1.52f, 1.18f, 1.34f };
    float Weights[SIZE] = { 38.0f, 30.0f, 45.0f, 42.0f, 44.0f };

    FILE* file = fopen("tti.txt", "wt");
    if(file == NULL)
    {
        printf("Unable to open file \"tti.txt\"!");
        return 1;
    }

    for(int i = 0; i < SIZE; i++)
    {
        fprintf(file, "%f\n", calcTTI(Weights[i], Heights[i]));
    }

    fclose(file);

    float TTI[SIZE];
    feladat3(TTI, SIZE);
    feladat4(TTI, SIZE);

    printf("Add meg az intervallum also hatarat! [%d ; %d]\n", MIN, MAX);
    int intervalMin = readInt(MIN, MAX);

    printf("Add meg az intervallum felso hatarat! [%d ; %d]\n", intervalMin, MAX);
    int intervalMax = readInt(intervalMin, MAX);

    printf("%d gyerek esik a megadott intervallumba\n", feladat6(TTI, SIZE, intervalMin, intervalMax));
    return 0;
}

void feladat3(float* arr, int size)
{
    FILE* file = fopen("tti.txt", "rt");
    if(file == NULL)
    {
        printf("Unable to open file \"tti.txt\"!");
        return;
    }

    for(int i = 0; i < SIZE; i++)
    {
        fscanf(file, "%f", &arr[i]);
    }

    fclose(file);

    int min = 0;
    for(int i = 0; i < size; i++)
    {
        min = i;
        for(int k = i + 1; k < size; k++)
        {
            if(arr[k] < arr[min])
                min = k;
        }

        if(i != min)
        {
            float temp = arr[i];
            arr[i] = arr[min];
            arr[min] = temp;
        }
    }
}

void feladat4(float* arr, int size)
{
    for(int i = 0; i < size; i++)
    {
        printf("%f\n", arr[i]);
    }
}

int feladat6(float* arr, int size, int min, int max)
{
    int count = 0;
    for(int i = 0; i < size; i++)
    {
        if(arr[i] > min && arr[i] < max)
            ++count;
    }

    return count;
}

int readInt(int min, int max)
{
    int num;
    while(scanf("%d", &num) != 1 || num < min || num > max)
    {
        printf("Invalid input!\n");
        clearBuffer();
    }

    return num;
}

void clearBuffer()
{
    while(getchar() != '\n');
}

float calcTTI(float weight, float height)
{
    return weight / (height * height);
}
