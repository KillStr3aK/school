/*
            2022
    Parhuzamos Algoritmusok
      Ivacs David, OYFTRQ
*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void primeNum(int);
void printPrimes(int);

int main(void)
{
    int boundaries[] = { 1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000, 10000, 11000, 12000, 13000, 14000, 15000, 16000, 17000, 18000, 19000, 20000 };
    int length = sizeof(boundaries) / sizeof(int);

    for(int i = 0; i < length; i++)
    {
        printPrimes(boundaries[i]);
    }

	return 0;
}

void printPrimes(int number)
{
    printf("Primszamok %d - ig:\n", number);

    clock_t begin = clock();
    primeNum(number);
    clock_t end = clock();

    double elapsedTime = (double)(end - begin) / CLOCKS_PER_SEC;
    printf("Eltelt ido: %.3f masodperc.\n", elapsedTime);
}

void primeNum(int number)
{
    int i, c;
    int a = 1;

    while (a <= number)
    {
        c = 0;
        i = 2;

        while (i <= a / 2)
        {
            if (a % i == 0)
            {
                c++;
                break;
            }

            i++;
        }

        if (c == 0 && a != 1)
        {
            printf("%d|", a);
        }

        a++;
    }

    printf("\n\n");
}
