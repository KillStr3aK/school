/*
          2022
    Szamitogep Grafika
    Ivacs David, OYFTRQ
*/

#ifndef LINE_H
    #define LINE_H
    #include <stdbool.h>
    #include "point.h"

    #define MAX_LINE_COUNT 10

    typedef struct Line
    {
        Point   Start;
        Point   End;
    } Line;

    typedef struct Lines
    {
        Line    Lines[MAX_LINE_COUNT];
        int     Index;
        int     Count;
    } Lines;
#endif