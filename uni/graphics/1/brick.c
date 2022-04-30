/*
          2022
    Szamitogep Grafika
    Ivacs David, OYFTRQ
*/

#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>

typedef struct
{
    float   A;
    float   B;
    float   Height;
} Brick;

Brick       Brick_Create(float, float, float);
float       Brick_CalculateVolume(Brick);
float       Brick_CalculateSurface(Brick);
bool        Brick_IsSquare(Brick);

#define BRICK_MIN_SIZE 1.0
#define BRICK_MAX_SIZE 999.0

float ReadFloat(const char*, float, float);
void ClearBuffer();

int main(void)
{
    float a = ReadFloat("Add meg az 'A' oldalt", BRICK_MIN_SIZE, BRICK_MAX_SIZE);
    float b = ReadFloat("Add meg az 'B' oldalt", BRICK_MIN_SIZE, BRICK_MAX_SIZE);
    float height = ReadFloat("Add meg a magassagot", BRICK_MIN_SIZE, BRICK_MAX_SIZE);
    Brick brick = Brick_Create(a, b, height);

    printf("Terfogat: %.2fcm^3\n", Brick_CalculateVolume(brick));
    printf("Felszin: %.2fcm^2\n", Brick_CalculateSurface(brick));
    printf(Brick_IsSquare(brick) ? "Van negyzet alaku lapja\n" : "Nincs negyzet alaku lapja\n");
    
    system("pause");
    return 0;
}

float ReadFloat(const char* msg, float min, float max)
{
    printf("%s\n", msg);

    float num = .0f;
    while(scanf("%f", &num) != 1 || num < min || num > max)
    {
        printf("Hibas adat!\n");
        ClearBuffer();
    }

    return num;
}

void ClearBuffer()
{
    char c;
    while((c = getchar()) != '\n');
}

Brick Brick_Create(float a, float b, float height)
{
    Brick brick;
    brick.A = a;
    brick.B = b;
    brick.Height = height;
    return brick;
}

float Brick_CalculateVolume(Brick brick)
{
    return brick.A * brick.B * brick.Height;
}

float Brick_CalculateSurface(Brick brick)
{
    return brick.A * brick.Height + brick.B * brick.Height + brick.A * brick.B;
}

bool Brick_IsSquare(Brick brick)
{
    return brick.A == brick.B || brick.A == brick.Height || brick.B == brick.Height;
}