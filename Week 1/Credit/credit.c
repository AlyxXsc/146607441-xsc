#include <cs50.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool amex(int len, int a, int b);
bool mastercard(int len, int a, int b);
bool visa(int len, int x);

int main(void)
{
    // Declaring Variables.
    int len = 0;
    string num;

    // Prompts user for Card Number.
    num = get_string("Number: ");
    len = strlen(num);

    // Converts string to array of integers.
    for (int i = 0; i < len; i++)
    {
        num[i] -= 48;
    }
    // Creates An Array Of The Checksum Digits From Card Array.
    int chksum[len];
    for (int x = 0; x < len; x++)
    {
        chksum[x] = num[x];
    }
    int x = (len - 2);
    while (x >= 0)
    {
        if (chksum[x] > 4)
        {
            int prod = chksum[x] * 2;
            chksum[x] = (prod % 10) + 1;
        }
        else
        {
            chksum[x] = chksum[x] * 2;
        }
        x--;
        x--;
    }

    // Adds Up The Checksum Of The Digits.
    int total = 0;
    for (int y = 0; y < len; y++)
    {
        total = total + chksum[y];
    }

    // Prints Out The Name And Validity Of The Card.
    if ((total % 10) == 0)
    {
        int a = num[0];
        int b = num[1];
        if (amex(len, a, b) == true)
        {
            printf("AMEX\n");
        }
        else if (visa(len, a) == true)
        {
            printf("VISA\n");
        }
        else if (mastercard(len, a, b) == true)
        {
            printf("MASTERCARD\n");
        }
        else
        {
            printf("INVALID\n");
        }
    }
    else
    {
        printf("INVALID\n");
    }
    return 0;
}

bool amex(int len, int a, int b)
{
    if (len == 15)
    {
        if (a == 3)
        {
            if ((b == 4) || (b == 7))
            {
                return true;
            }
        }
    }
    return false;
}

bool mastercard(int len, int a, int b)
{
    if (len == 16)
    {
        if (a == 5)
        {
            if ((b >= 1) && (b <= 5))
            {
                return true;
            }
        }
    }
    return false;
}

bool visa(int len, int x)
{
    if ((len == 13) || (len == 16))
    {
        if (x == 4)
        {
            return true;
        }
    }
    return false;
}
