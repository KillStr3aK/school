/*
            2022
    Parhuzamos Algoritmusok
      Ivacs David, OYFTRQ
*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define RANDOM_MIN 0
#define RANDOM_MAX 1000

#define HIGH_MAX 2000

int getRandomInt(int, int);
int readInt(int, int);
void clearBuffer(void);

int main(void)
{
	srand(time(NULL));

	int first = getRandomInt(RANDOM_MIN, RANDOM_MAX);
	int second = getRandomInt(RANDOM_MIN, RANDOM_MAX);

	printf("%d + %d = ?\n", first, second);

	clock_t begin = clock();
	int guess = readInt(RANDOM_MIN, HIGH_MAX);
	clock_t end = clock();

	int answer = first + second;
	if(answer == guess)
    {
		printf("A valasz helyes (%d)", answer);
	} else {
		printf("A valasz helytelen\nA helyes megoldas: %d (Valaszod: %d)", answer, guess);
	}

	double elapsedTime = (double)(end - begin) / CLOCKS_PER_SEC;
	printf("\nEltelt ido: %.2f masodperc\n", elapsedTime);
	return 0;
}

int getRandomInt(int min, int max)
{
    return (rand() % (max - min) + 1) + min;
}

int readInt(int min, int max)
{
    int num;
    while(scanf("%d", &num) != 1 || num < min || num > max)
    {
        printf("Hibas adat!\n");
        clearBuffer();
    }

    return num;
}

void clearBuffer(void)
{
    char c;
    while((c = getchar()) != '\n');
}
