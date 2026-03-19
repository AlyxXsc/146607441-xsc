#include <cs50.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool only_digits(string s);

void rotate(char *c, int n);

int main(int argc, string argv[])
{
    // Declaring Variables.
    long int key = 0;
    string text = NULL;
    int i = 0;
    int j = 0;
    // Checks If Key Input Is Valid.
    if ((argc != 2) || (only_digits(argv[1]) == false))
    {
        printf("Usage: ./caesar KEY\n");
        return 1;
    }

    // Extracts The Key From User Input.

    while (argv[1][i + 1] != '\0')
    {
        i++;
    }

    key = atoi(argv[1]);

    while (key > 26)
    {
        key %= 26;
    }

    // Prompts User For Text To Encrypt.
    text = get_string("plaintext: ");

    // Encrypts Text Using Key Extracted From User Input.
    i = 0;
    while (text[i] != '\0')
    {
        if (isalpha(text[i]))
        {
            rotate(&text[i], key);
        }
        i++;
    }

    // Outputs Encrypted Text.
    printf("ciphertext: %s\n", text);
    return 0;
}

bool only_digits(char s[])
{
    int a = 0;
    int b = 0;
    while (s[a] != '\0')
    {
        if (!(isdigit(s[a])))
        {
            b++;
        }
        a++;
    }
    if (b > 0)
    {
        return false;
    }

    return true;
}

void rotate(char *c, int key)
{
    *c += key;
    if (!(isalpha(*c)))
    {
        *c -= 26;
    }
    return;
}
