#include <cs50.h>
#include <stdio.h>

void print_row(int spaces, int bricks);

int main(void)
{
    int height = 0;
    // Prompts The User For A Pyramid Height.
    do
    {
        height = get_int("Enter the pyramid height: ");
    }
    while (height < 1);
    for (int bricks = 1; bricks <= height; bricks++)
    {
        // Prints Bricks And Spaces Per Line.
        int spaces = height - bricks;
        print_row(spaces, bricks);
    }
    return 0;
}

void print_row(int spaces, int bricks)
{
    // Positions The First Set Of Bricks.
    for (int i = 0; i < spaces; i++)
    {
        printf(" ");
    }
    // Prints The First Set Of Bricks.
    for (int i = 0; i < bricks; i++)
    {
        printf("#");
    }
    // Seperates The First Set Of Bricks From The Second.
    printf("  ");
    // Prints The Second Set Of Bricks.
    for (int i = 0; i < bricks; i++)
    {
        printf("#");
    }
    printf("\n");
    return;
}
