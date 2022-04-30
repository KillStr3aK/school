/*
            2022
    Parhuzamos Algoritmusok
      Ivacs David, OYFTRQ
*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int getRandomInt(int, int);

int main(int argc, char* argv[])
{
    if(argc != 2)
    {
        printf("Legalabb egy parameter szukseges!\n");
        return 1;
    }

    srand(time(NULL));
    char ABC[] = { "abcdefghijklmnopqrstuwxyzABCDEFGHIJKLMNOPQRSTUWXYZ0123456789\n " };
    int length = sizeof(ABC) / sizeof(char);

    int chars = atoi(argv[1]);

    FILE* file = fopen("oyftrq.txt", "w");
    if(file == NULL)
    {
        printf("Fajlmuveleti hiba\n");
        return 1;
    }

    for(int i = 0; i < chars; i++)
    {
        fprintf(file, "%c\n", ABC[getRandomInt(0, length - 1)]);
    }

    fclose(file);
	return 0;
}

int getRandomInt(int min, int max)
{
    return (rand() % (max - min) + 1) + min;
}
