//feladat: https://cdn.discordapp.com/attachments/322034844412542978/800127682225766400/unknown.png
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#define MERET 5
#define MIN 1
#define MAX 95

typedef struct
{
    int Mezo[5];
} Lotto;

void feladat3(Lotto*, Lotto*, int);
void feladat5(Lotto*, int);

void readStruct(Lotto*);
void clearBuffer();

bool isValidLotto(const Lotto*);

int main()
{
    Lotto lotto;
    lotto.Mezo[0] = 5;
    lotto.Mezo[1] = 27;
    lotto.Mezo[2] = 32;
    lotto.Mezo[3] = 67;
    lotto.Mezo[4] = 90;

    Lotto mezok[MERET];
    for(int i = 0; i < MERET; i++)
    {
        readStruct(&mezok[i]);
    }

    feladat3(&lotto, mezok, MERET);
    feladat5(mezok, MERET);
    return 0;
}

void readStruct(Lotto* l)
{
    while(scanf("%d %d %d %d %d", &l->Mezo[0], &l->Mezo[1], &l->Mezo[2], &l->Mezo[3], &l->Mezo[4]) != 5 || !isValidLotto(l))
    {
        printf("hulye vagy!\n");
        clearBuffer();
    }
}

//5 27  32  67  90
//2 3   4   5   6

void feladat3(Lotto* winner, Lotto* rows, int size)
{
    int good[size];
    for(int i = 0; i < size; i++)
    {
        good[i] = 0;

        for(int k = 0; k < size; k++)
        {
            for(int j = 0; j < size; j++)
            {
                if(rows[i].Mezo[j] == winner->Mezo[k])
                {
                    ++good[i];
                }
            }
        }

        printf("%d. sorban %d talalat\n", i + 1, good[i]);
    }

    int best = 0;
    for(int i = 0; i < size; i++)
    {
        if(good[i] > good[best])
            best = i;
    }

    if(good[best] != 0) printf("A(z) %d. sorban volt a legtobb talalat! (%d db)\n", best + 1, good[best]);
    else printf("Egyik sorban sem volt talalat!\n");
}

void feladat5(Lotto* rows, int size)
{
    FILE* file = fopen("lotto.txt", "wt");
    if(file == NULL)
    {
        printf("Unable to open file \"lotto.txt\"!");
        return;
    }

    for(int i = 0; i < size; i++)
    {
        for(int k = 0; k < size; k++)
            fprintf(file, "%d ", rows[i].Mezo[k]);

        fprintf(file, "\n");
    }

    fclose(file);
}

bool isValidLotto(const Lotto* l)
{
    for(int i = 0; i < MERET; i++)
    {
        if(l->Mezo[i] >= MAX || l->Mezo[i] <= MIN) return false;
    }

    for(int i = 1; i < MERET; i++)
    {
        if(l->Mezo[i] < l->Mezo[i - 1] || l->Mezo[i] == l->Mezo[i - 1]) return false;
    }

    return true;
}

void clearBuffer()
{
    while(getchar() != '\n');
}
