#include <cs50.h>
#include <ctype.h>
#include <stdio.h>
#include <string.h>

int main(int argc, char *argv[])
{
    // Declaring Variables.
    char text[100];
    int i = 0;
    char spot;
    int charpos = 0;
    int a = 0;
    int alphavolume = 0;

    // Checks Input Is Provided By User.
    if (argc != 2)
    {
        printf("Usage: ./substitution key\n");
        return 1;
    }

    // Checks Order And Length Of Key.
    while (argv[1][a] != 0)
    {
        if (argv[1][26] != 0)
        {
            printf("Key must contain 26 characters.\n");
            return 1;
        }

        // Checks If Key Consists Of Letters Only.
        char chars = argv[1][a];
        if (isalpha(chars))
        {
            a++;
        }
        else
        {
            printf("Usage: ./substitution key\n");
            return 1;
        }
    }

    // Checks To Make Sure Letters Are Not Repeated.
    char trial_text[27];
    strcpy(trial_text, argv[1]);
    int sum = 0;
    for (int b = 0; b < strlen(trial_text); b++)
    {
        if (islower(trial_text[b]))
        {
            trial_text[b] -= 32;
        }
    }
    for (int b = 0; b < 26; b++)
    {
        char ab = 'A' + b;
        if ((strchr(trial_text, ab)) == 0)
        {
            printf("Each character must appear once.\n");
            return 1;
        }
    }
    // Prompts User For Text To Encrypt.
    string tmp_text = get_string("plaintext: ");
    strcpy(text, tmp_text);

    // Encrypts Text Input Using The Substitution Key.
    while (text[i] != '\0')
    {
        spot = text[i];
        if (isalpha(spot))
        {
            if (isupper(spot))
            {
                charpos = spot % 65;
                spot = argv[1][charpos];
                if (spot > 97)
                {
                    spot = spot - 32;
                }
                text[i] = spot;
            }
            else if (islower(spot))
            {
                charpos = spot % 97;
                spot = argv[1][charpos];
                if (spot < 97)
                {
                    spot = spot + 32;
                }
                text[i] = spot;
            }
        }
        i++;
    }

    // Outputs Encrypted Text.
    printf("ciphertext: %s\n", text);
    return 0;
}
