#include <stdio.h>
#include <stdlib.h>

#include <stdbool.h>

#define DATE_FORMAT_SLASH   "%d/%d/%d" /* yyyy/hh/dd */
#define DATE_FORMAT_HYPHEN  "%d-%d-%d" /* yyyy-hh-dd */
#define DATE_FORMAT_DOT     "%d.%d.%d" /* yyyy.hh.dd */

enum Months {
    January = 1,
    February,
    March,
    April,
    May,
    June,
    July,
    August,
    September,
    October,
    November,
    December
};

typedef struct {
    int Year;
    int Month;
    int Day;
} Date;

void readDate(Date*, const char*);
void writeDate(Date);

Date getOlderDate(Date, Date);

bool isValidDate(Date);
bool isLeapYear(int);

void clearBuffer();

void readDate(Date* date, const char* format)
{
    while(scanf(format, &date->Year, &date->Month, &date->Day) != 3 || !isValidDate(*date))
    {
        printf("Invalid input or format!\n");
        clearBuffer();
    }
}

void writeDate(Date date)
{
    printf("%d/%d/%d\n", date.Year, date.Month, date.Day);
}

Date getOlderDate(Date d1, Date d2)
{
    if(d1.Year == d2.Year)
    {
        if(d1.Month == d2.Month)
        {
            return d1.Day < d2.Day ? d1 : d2;
        } else
        {
            return d1.Month < d2.Month ? d1 : d2;
        }
    } else
    {
        return d1.Year < d2.Year ? d1 : d2;
    }

    return d1;
}

bool isValidDate(Date date)
{
    int daysInMonths[] = {-1, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
    if(date.Year < 1587 || date.Year > 2040)
        return false;

    if(date.Month < 0 || date.Month > 12)
        return false;

    if(isLeapYear(date.Year))
        daysInMonths[February] = 29;

    if(date.Day < 1 || date.Day > daysInMonths[date.Month])
        return false;

    return true;
}

bool isLeapYear(int year)
{
    return ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0);
}

void clearBuffer()
{
    char c;
    while((c = getchar()) != '\n');
}
