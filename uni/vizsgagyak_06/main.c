#include <stdio.h>
#include <stdlib.h>

#define ARR_SIZE 5
#define IN_MIN 3600
#define IN_MAX 7200

typedef struct
{
    int Ora;
    int Perc;
    int Masodperc;
} Korido;

void readData(char**, Korido*, int);
void printTable(char**, Korido*, int);
void printTimesInSec(char**, Korido*, int);
void printBetweenTime(int, int, char**, Korido*, int);

int convertToSeconds(Korido);
int readInt(int, int);

void clearBuffer();

int main()
{
    char* Names[ARR_SIZE];
    for(int i = 0; i < ARR_SIZE; i++)
    {
        Names[i] = (char*)calloc(16, sizeof(char));
    }

    Korido Times[ARR_SIZE];

    readData(Names, Times, ARR_SIZE);
    printTable(Names, Times, ARR_SIZE);
    printTimesInSec(Names, Times, ARR_SIZE);
    int lower = readInt(IN_MIN, IN_MAX);
    int upper = readInt(lower, IN_MAX);
    printBetweenTime(lower, upper, Names, Times, ARR_SIZE);

    for(int i = 0; i < ARR_SIZE; i++)
    {
        free(Names[i]);
    }

    return 0;
}

void printTable(char** names, Korido* times, int size)
{
    printf("TIME\tNAME\n");
    for(int i = 0; i < size; i++)
    {
        printf("%d:%d:%d\t%s\n", times[i].Ora, times[i].Perc, times[i].Masodperc, *(names + i));
    }
}

void readData(char** names, Korido* times, int size)
{
    FILE* file = fopen("forma1.txt", "rt");
    if(file == NULL)
    {
        printf("Unable to open file \"forma1.txt\"!");
        return;
    }

    for(int i = 0; i < size; i++)
    {
        fscanf(file, "%s %d %d %d", *(names + i), &times[i].Ora, &times[i].Perc, &times[i].Masodperc);
    }

    fclose(file);
}

void printTimesInSec(char** names, Korido* times, int size)
{
    FILE* file = fopen("forma1_times.txt", "wt");
    if(file == NULL)
    {
        printf("Unable to open file \"forma1_times.txt\"!");
        return;
    }

    for(int i = 0; i < size; i++)
    {
        printf("%s: %d\n", *(names + i), convertToSeconds(*(times + i)));
        fprintf(file, "%s %d\n", *(names + i), convertToSeconds(*(times + i)));
    }

    fclose(file);
}

void printBetweenTime(int min, int max, char** names, Korido* times, int size)
{
    int seconds;
    for(int i = 0; i < size; i++)
    {
        seconds = convertToSeconds(*(times + i));
        if(seconds > min && seconds < max)
        {
            printf("%d:%d:%d %s\t(%d seconds)\n", times[i].Ora, times[i].Perc, times[i].Masodperc, *(names + i), seconds);
        }
    }
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

int convertToSeconds(Korido k)
{
    return (k.Ora * 3600 + k.Perc * 60 + k.Masodperc);
}

void clearBuffer()
{
    while(getchar() != '\n');
}
