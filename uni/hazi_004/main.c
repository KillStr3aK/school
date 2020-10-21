#include <stdio.h>
#include <stdlib.h>

#include <string.h>
#include <ctype.h>

#define N 100
#define ESC 27

void ReadLine(char*);

void Reverse(const char*, char*);
void ToCapital(const char*, char*);
int CharCount(const char*);

int main()
{
    char Szoveg[N];
    char Forditott[N];
    char Capital[N];

    ReadLine(Szoveg);
    Reverse(Szoveg, Forditott);
    ToCapital(Szoveg, Capital);

    printf("Eredeti: %s\n", Szoveg);
    printf("Forditott: %s\n", Forditott);
    printf("Nagybetus: %s\n", Capital);
    printf("\nA szovegben %d db \"E\" betu van", CharCount(Szoveg));
    return 0;
}

void ToCapital(const char* str, char* targetstr)
{
    int i = 0;

    int hossz = strlen(str);
    while(i < hossz)
    {
        *targetstr++ = toupper(str[i++]);
    }

    *targetstr = '\0';
}

void Reverse(const char* str, char* targetstr)
{
    int i = strlen(str)-1;

    while (i >= 0)
    {
        *targetstr++ = str[i--];
    }

    *targetstr = '\0';
}

int CharCount(const char* str)
{
    int db = 0;
    int i;
    int hossz = strlen(str);
    for(i = 0; i < hossz; i++)
    {
        if(str[i] == 'E')
            ++db;
    }

    return db;
}

void ReadLine(char* str)
{
    int i = 0;
    char c;

    while((c = getchar()) != /*ESC*/'\n' && i < N - 1)
    {
        str[i++] = c;
    }

    str[i] = '\0';
}
