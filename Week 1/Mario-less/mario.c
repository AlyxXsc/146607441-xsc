#include <cs50.h>
#include <stdio.h>

void print_row(int spaces, int bricks);

int main(void)
{

    // Prompts user for pyramid height.
    int height = 0;
    do
    {
        height = get_int("Enter the pyramid height: ");
    }
    while (height <= 0);

    // Prints pyramid of that height.
    for (int bricks = 1; bricks <= height; bricks++)
    {
        int spaces = height - bricks;
        print_row(spaces, bricks);
    }
}

void print_row(int spaces, int bricks)
{
    // Print Spaces.
    for (int i = 0; i < spaces; i++)
    {
        printf(" ");
    }

    // Print Bricks.
    for (int i = 0; i < bricks; i++)
    {
        printf("#");
    }
    printf("\n");
    return;
}
