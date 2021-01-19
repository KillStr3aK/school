#include <stdio.h>
#include <stdlib.h>

#define ARR_SIZE 5
#define IN_MIN 1
#define IN_MAX 5

void printTable(char**, int*, int);
void sortArray(char**, int*, int);
void writeToFile(char**, int*, int);

void getTeamFromPlace(int, char*, int*);
int isDraw(int*, int);

int readInt(int, int);
void clearBuffer();

int main()
{
    char* teamNames[] = { "CodeFighters", "VIP", "BitCoins", "4Byte", "ByterTeam" };
    int teamScores[5] = { 88, 63, 75, 69, 87 };

    printTable(teamNames, teamScores, ARR_SIZE);
    sortArray(teamNames, teamScores, ARR_SIZE);
    writeToFile(teamNames, teamScores, ARR_SIZE);

    int place = readInt(IN_MIN, IN_MAX);
    char teamName[16];
    int teamScore;
    getTeamFromPlace(place, teamName, &teamScore);
    printf("A(z) %d. helyen a %s csapat all %d ponttal.\n", place, teamName, teamScore);

    int drawPlace = isDraw(teamScores, ARR_SIZE);
    if(drawPlace == 0) printf("Nincs holtverseny.\n");
    else printf("A(z) %d. helyen van holtverseny!\n", drawPlace);
    return 0;
}

void printTable(char** teamName, int* teamScore, int size)
{
    printf("No.\tSCORE\tNAME\n");
    for(int i = 0; i < size; i++)
    {
        printf("%d\t%d\t%s\n", i + 1, *(teamScore + i), *(teamName + i));
    }
}

void sortArray(char** teamName, int* teamScore, int size)
{
    int min = 0;
    for(int i = 0; i < size; i++)
    {
        min = i;
        for(int k = i + 1; k < size; k++)
        {
            if(*(teamScore + k) > *(teamScore + min))
            {
                min = k;
            }
        }

        if(i != min)
        {
            char* tempName = *(teamName + i);
            int tempScore = *(teamScore + i);

            *(teamName + i) = *(teamName + min);
            *(teamScore + i) = *(teamScore + min);

            *(teamName + min) = tempName;
            *(teamScore + min) = tempScore;
        }
    }
}

void writeToFile(char** teamName, int* teamScore, int size)
{
    FILE* file = fopen("csapat.txt", "wt");
    if(file == NULL)
    {
        printf("Nem sikerult megnyitni a \"csapat.txt\" fajlt!");
        return;
    }

    for(int i = 0; i < size; i++)
    {
        fprintf(file, "%d %s\n", *(teamScore + i), *(teamName + i));
    }

    fclose(file);
}

void getTeamFromPlace(int placement, char* teamName, int* teamScore)
{
    FILE* file = fopen("csapat.txt", "rt");
    if(file == NULL)
    {
        printf("Nem sikerult megnyitni a \"csapat.txt\" fajlt!");
        return;
    }

    for(int i = 0; i < placement; i++)
    {
        fscanf(file, "%d %s", teamScore, teamName);
    }

    fclose(file);
}

int isDraw(int* arr, int size)
{
    for(int i = 0; i < size; i++)
    {
        for(int k = i + 1; k < size; k++)
        {
            if(*(arr + i) == *(arr + k))
                return i + 1;
        }
    }

    return 0;
}

int readInt(int min, int max)
{
    int num;
    while(scanf("%d", &num) != 1 || num < min || num > max)
    {
        printf("Hibas bemenet!");
        clearBuffer();
    }

    return num;
}

void clearBuffer()
{
    while(getchar() != '\n');
}
