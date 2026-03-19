#include <cs50.h>
#include <ctype.h>
#include <stdio.h>
#include <string.h>

int scores[] = {1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 1, 1, 3, 10, 1, 1, 1, 1, 4, 4, 8, 4, 10};

// Compute Player Scores.
int compute(char word[], int score)
{
    int pos = 0;
    int i = 0;
    while (word[i] != 0)
    {
        if (isalpha(word[i]))
        {
            if (isupper(word[i]))
            {
                pos = pos + (word[i] - 65);
                score = score + scores[pos];
                pos = 0;
            }
            else
            {
                pos = pos + (word[i] - 97);
                score = score + scores[pos];
                pos = 0;
            }
            i++;
        }
        else
        {
            i++;
        }
    }
    return score;
}

int main()
{
    // Declare Variables.
    int score[] = {0, 0};
    char word[2][20];
    // Prompts The Players for words.
    for (int x = 0; x < 2; x++)
    {
        string words = get_string("Player %d: ", (x + 1));
        strcpy(word[x], words);
    }

    // Computes Scores.
    for (int x = 0; x < 2; x++)
    {
        int a = compute(word[x], score[x]);
        if (a == 0)
        {
            return 1;
        }
        else
        {
            score[x] = a;
        }
    }

    // Outputs The Winner.
    if (score[0] > score[1])
    {
        printf("Player 1 Wins!\n");
    }
    else if (score[0] < score[1])
    {
        printf("Player 2 Wins!\n");
    }
    else
    {
        printf("Tie!\n");
    }
    return 0;
}
