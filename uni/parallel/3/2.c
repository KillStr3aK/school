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

#define THREADS 60

void wait(void*);

int main(void)
{
    pthread_t threads[THREADS];
    for(int i = 0; i < THREADS; i++)
    {
        pthread_create(&threads[i], NULL, wait, NULL);
        pthread_join(threads[i], NULL);
    }

	return 0;
}

void wait(void* __)
{
    printf("1 masodperc varakozas\n");
    sleep(1);
}
