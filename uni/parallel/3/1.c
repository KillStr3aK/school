/*
            2022
    Parhuzamos Algoritmusok
      Ivacs David, OYFTRQ
*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include <unistd.h>
#include <pthread.h>

void wait(void*);

int main(void)
{
    printf("8 masodperc varakozas\n");
    sleep(8);

    pthread_t first;
    pthread_create(&first, NULL, wait, NULL);
    pthread_join(first, NULL);
	return 0;
}

void wait(void* __)
{
    printf("4 masodperc varakozas\n");
    sleep(4);
}
