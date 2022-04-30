/*
            2022
    Parhuzamos Algoritmusok
      Ivacs David, OYFTRQ
*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(int argc, char* argv[])
{
    if(argc != 3)
    {
        printf("Legalabb ket parameter szukseges!\n");
        return 1;
    }

    FILE* file = fopen(argv[1], "w");
    if(file == NULL)
    {
        printf("Fajlmuveleti hiba a(z) \"%s\" fajlnal.\n", argv[1]);
        return 1;
    }

    srand(time(NULL));
    clock_t begin = clock();

    int count = atoi(argv[2]);
    for(int i = 0; i < count; i++)
    {
        fprintf(file, "asd\n");
    }

    clock_t end = clock();
    fclose(file);

    double elapsedTime = (double)(end - begin) / CLOCKS_PER_SEC;
    printf("Eltelt ido: %.2f", elapsedTime);
	return 0;
}
