#include <stdio.h>
#include <stdlib.h>

#include <string.h>

#define MAX_SIZE 100

void encryptString(const char*, char*);
void decryptString(const char*, char*);
void readLine(char*);

/*
    Nem akartam nagyon túlbonyolítani, a "titkosítás" annyiból áll, hogy a karakterek ASCII kódjához hozzáad ötöt, ami már 1 új karaktert ad vissza
    Eredeti: http://www.trytoprogram.com/c-examples/c-program-to-encrypt-and-decrypt-string/

    /!\ Karakterekbõl és számokból álló szövegeken mûködik /!\
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
