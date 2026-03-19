#include <cs50.h>
#include <stdio.h>

int main(void)
{
    // Declaring variables.
    int change = 0;
    int cent[] = {25, 10, 5, 1};
    int coins = 0;

    // Prompts the user for the change owed.
    do
    {
        change = get_int("Change owed: ");
    }
    while (change < 0);
    // Calculates the amount of coins to be paid.
    int i = 0;
    while (change != 0)
    {
        while (change >= cent[i])
        {
            change = change - cent[i];
            coins++;
        }
        i++;
    }

    // Outputs the number of coins to be used in returning change.
    printf("Coins: %d\n", coins);
}
