/*
            2022
    Parhuzamos Algoritmusok
      Ivacs David, OYFTRQ
*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define MAX_SIZE 5

#define ARR_INT "arrayint.txt"
#define ARR_FLOAT "arrayfloat.txt"
#define ARR_LONG "arraylong.txt"

void writeIntArray(const char*, const int*, int);
void writeFloatArray(const char*, const float*, int);
void writeLongArray(const char*, const long*, int);

void readIntArray(const char*, int*, int);
void readFloatArray(const char*, float*, int);
void readLongArray(const char*, long*, int);

FILE* openFile(const char*, const char*);

int main(void)
{
    int ArrayInt[MAX_SIZE] = { 1, 2, 3, 4, 5 };
    float ArrayFloat[MAX_SIZE] = { 1.0f, 2.0f, 3.0f, 4.0f, 5.0f };
    long ArrayLong[MAX_SIZE] = { 1, 2, 3, 4, 5 };

    writeIntArray(ARR_INT, ArrayInt, MAX_SIZE);
    writeFloatArray(ARR_FLOAT, ArrayFloat, MAX_SIZE);
    writeLongArray(ARR_LONG, ArrayLong, MAX_SIZE);

    int ReadArrayInt[5];
    readIntArray(ARR_INT, ReadArrayInt, MAX_SIZE);

    printf("Beolvasott ertek: (int)\n");
    for(int i = 0; i < MAX_SIZE; i++)
    {
        printf("%d ", ReadArrayInt[i]);
    }

    printf("\n\n");

    float ReadArrayFloat[5];
    readFloatArray(ARR_FLOAT, ReadArrayFloat, MAX_SIZE);

    printf("Beolvasott ertek: (float)\n");
    for(int i = 0; i < MAX_SIZE; i++)
    {
        printf("%.2f ", ReadArrayFloat[i]);
    }

    printf("\n\n");

    long ReadArrayLong[5];
    readLongArray(ARR_LONG, ReadArrayLong, MAX_SIZE);

    printf("Beolvasott ertek: (long)\n");
    for(int i = 0; i < MAX_SIZE; i++)
    {
        printf("%ld ", ReadArrayLong[i]);
    }

    printf("\n");

	return 0;
}

FILE* openFile(const char* filepath, const char* mode)
{
    FILE* file = NULL;
    if(!(file = fopen(filepath, mode)))
    {
        printf("Fajlmuveleti hiba \"%s\"\n", filepath);
    }

    return file;
}

void writeIntArray(const char* filepath, const int* arr, int size)
{
    FILE* file = openFile(filepath, "w");
    if(fwrite(arr, sizeof(int), size, file) != size)
    {
        printf("Nem sikerult kiirni a tombot a(z) \"%s\" fajlba.\n", filepath);
    }

    fclose(file);
}

void writeFloatArray(const char* filepath, const float* arr, int size)
{
    FILE* file = openFile(filepath, "w");
    if(fwrite(arr, sizeof(float), size, file) != size)
    {
        printf("Nem sikerult kiirni a tombot a(z) \"%s\" fajlba.\n", filepath);
    }

    fclose(file);
}

void writeLongArray(const char* filepath, const long* arr, int size)
{
    FILE* file = openFile(filepath, "w");
    if(fwrite(arr, sizeof(long), size, file) != size)
    {
        printf("Nem sikerult kiirni a tombot a(z) \"%s\" fajlba.\n", filepath);
    }

    fclose(file);
}

void readIntArray(const char* filepath, int* arr, int size)
{
    FILE* file = openFile(filepath, "r");
    if(fread(arr, sizeof(int), size, file) != size)
    {
        printf("Nem sikerult kiolvasni a tombot a(z) \"%s\" fajlbol.\n", filepath);
    }

    fclose(file);
}

void readFloatArray(const char* filepath, float* arr, int size)
{
    FILE* file = openFile(filepath, "r");
    if(fread(arr, sizeof(float), size, file) != size)
    {
        printf("Nem sikerult kiolvasni a tombot a(z) \"%s\" fajlbol.\n", filepath);
    }

    fclose(file);
}

void readLongArray(const char* filepath, long* arr, int size)
{
    FILE* file = openFile(filepath, "r");
    if(fread(arr, sizeof(long), size, file) != size)
    {
        printf("Nem sikerult kiolvasni a tombot a(z) \"%s\" fajlbol.\n", filepath);
    }

    fclose(file);
}
