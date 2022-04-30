/*
            2022
    Parhuzamos Algoritmusok
      Ivacs David, OYFTRQ
*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int getRandomInt(int, int);

int main(int argc, char *argv[])
{
    if(argc != 3)
    {
        printf("Minimum 2 adatra van szukseg.\n");
        return 1;
    }

	srand(time(NULL));

    int a = atoi(argv[1]);
    int b = atoi(argv[2]);

    printf("%d\n", a >= b ? getRandomInt(b, a) : getRandomInt(a, b));
	return 0;
}

int getRandomInt(int min, int max)
{
    return (rand() % (max - min) + 1) + min;
}
