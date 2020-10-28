#include <stdio.h>
#include <stdlib.h>

void readLine(int*);
int sumOfDigits(int*);

int main()
{
    int szam;
    readLine(&szam);
    printf("A beirt szam szamjegyeinek az osszege: %d\n", sumOfDigits(&szam));
    return 0;
}

void readLine(int* num)
{
    char c;
    while(scanf("%d", num) != 1)
    {
        printf("Adj meg egy szamot!\n");
        while((c = getchar()) != '\n');
    }
}

int sumOfDigits(int* num)
{
    int sum = 0;
    while(*num != 0)
    {
        sum += *num % 10;
        *num /= 10;
    }

    return sum;
}
