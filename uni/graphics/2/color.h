/*
          2022
    Szamitogep Grafika
    Ivacs David, OYFTRQ
*/

#ifndef COLOR_H
    #define COLOR_H

    typedef struct RGB
    {
        int R;
        int G;
        int B;
    } RGB;

    typedef struct RGBA
    {
        RGB RGB;
        int A;
    } RGBA;

    void SetColor(RGB*, int, int, int, int);
#endif