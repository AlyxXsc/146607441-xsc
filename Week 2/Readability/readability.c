#include <cs50.h>
#include <ctype.h>
#include <stdio.h>
#include <string.h>

// Returns Number Of Letters In The Text.
float count_letters(char body[])
{
    int x = 0;
    float letters = 0;
    while (body[x] != 0)
    {
        if (isalpha(body[x]))
        {
            letters++;
            x++;
        }
        else
        {
            x++;
        }
    }
    return letters;
}

// Returns Number Of Words In The Text.
float count_words(char body[])
{
    int x = 0;
    float words = 1;
    while (body[x] != 0)
    {
        if (body[x] == ' ')
        {
            words++;
            x++;
        }
        else
        {
            x++;
        }
    }
    return words;
}

// Returns Number Of Sentences In The Text.
float count_sentences(char body[])
{
    int x = 0;
    float sentences = 0;
    while (body[x] != 0)
    {
        if ((body[x] == '.') || (body[x] == '?') || (body[x] == '!'))
        {
            sentences++;
            x++;
        }
        else
        {
            x++;
        }
    }
    return sentences;
}

// Computes The Coleman-Liau Index Of The Text.
float compute(float l, float s)
{
    float index = (0.0588 * l) - (0.296 * s) - 15.8;
    return index;
}

// Approximates The Index Of The Text To Nearest Whole Number.
int approx(float dec)
{
    int x = 0;
    while (dec > 1)
    {
        dec = dec - 1;
        x = x + 1;
    }
    if (dec > 0.5)
    {
        dec = dec - 0.5;
        x = x + 1;
    }
    return x;
}

int main(void)
{
    char body[500];
    // Prompts User For Body Of Text.
    string body_tmp = get_string("Text: ");
    strcpy(body, body_tmp);

    // Calculates The Parameters Of The Index.
    float letters = count_letters(body);
    float words = count_words(body);
    float sentences = count_sentences(body);
    float avg_letters = (letters / words);
    avg_letters = avg_letters * 100;
    float avg_sentences = (sentences / words);
    avg_sentences = avg_sentences * 100;
    float index = compute(avg_letters, avg_sentences);
    int final_index = approx(index);

    // Prints The Grade Level Of The Text.
    if (final_index < 1)
    {
        printf("Before Grade 1\n");
    }
    else if (final_index > 16)
    {
        printf("Grade 16+\n");
    }
    else
    {
        printf("Grade %d\n", final_index);
    }
}
