/*
            2022
    Parhuzamos Algoritmusok
      Ivacs David, OYFTRQ
*/

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

int main(void)
{
    while(true)
    {
        static int count = 0;
        if(count == 10)
            break;

        printf("%d\n", ++count);
        sleep(1);
    }

	return 0;
}
