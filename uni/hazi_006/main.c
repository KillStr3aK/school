#include <stdio.h>
#include <stdlib.h>

#include <string.h>

#define MAX_SIZE 100

void encryptString(const char*, char*);
void decryptString(const char*, char*);
void readLine(char*);

/*
    Nem akartam nagyon t�lbonyol�tani, a "titkos�t�s" annyib�l �ll, hogy a karakterek ASCII k�dj�hoz hozz�ad �t�t, ami m�r 1 �j karaktert ad vissza
    Eredeti: http://www.trytoprogram.com/c-examples/c-program-to-encrypt-and-decrypt-string/

    /!\ Karakterekb�l �s sz�mokb�l �ll� sz�vegeken m�k�dik /!\
*/

int main()
{
    char szoveg[MAX_SIZE];
    char encrypted[MAX_SIZE];
    char decrypted[MAX_SIZE];

    printf("Adj meg egy szoveget: ");

    readLine(szoveg);
    encryptString(szoveg, encrypted);
    decryptString(encrypted, decrypted);

    printf("\nOriginal:\t%s\nEncrypt:\t%s\nDecrypt:\t%s\n", szoveg, encrypted, decrypted);
    return 0;
}

void encryptString(const char* str, char* output)
{
    int i;
    int length = strlen(str);

    for(i = 0; i < length; i++)
    {
        output[i] = str[i] + 5;
    }

    output[i] = '\0';
}

void decryptString(const char* str, char* output)
{
    int i;
    int length = strlen(str);

    for(i = 0; i < length; i++)
    {
        output[i] = str[i] - 5;
    }

     output[i] = '\0';
}

void readLine(char* str)
{
    int i = 0;
    char c;

    while((c = getchar()) != '\n' && i < MAX_SIZE - 1)
    {
        str[i++] = c;
    }

    str[i] = '\0';
}
