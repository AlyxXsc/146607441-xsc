#include <math.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>

    /*
    */

int main(int argc, char *argv[])
{
    // Accept a single command-line argument
    if (argc != 2)
    {
        printf("Usage: ./recover FILE\n");
        return 1;
    }

    // Open the memory card
    FILE *card = fopen(argv[1], "rb");
    
    // Checks if file is readable
    if (card == NULL)
    {
        printf("Unable to read %s \x0a", argv[1]);
        return 1;
    }

    // Create a buffer for a block of data
    uint8_t *buffer = calloc(512, 1);
    struct stat fd;
    stat(argv[1], &fd);
    int size = roundf(fd.st_size / 512) * 512;
    uint8_t *buffer_s = calloc(size, 1);
    int jpeg = 0;

    // While there's still data left to read from the memory card
    int a = 1;
    int pos = 0;
    fread(buffer_s, 1, size, card);
    fread(buffer, 1, 512, card);
    while (a == 1)
    {
            if (buffer_s[pos] == 0xff && buffer_s[pos + 1] == 0xd8 && buffer_s[pos + 2] == 0xff)
            {
                char name[8];
                if (jpeg > 9)
                {
                    name[0] = '0';
                    name[1] = round((jpeg / 10) + 48);
                    name[2] = (jpeg % ((name[1] - 48) * 10)) + 48;
                    name[3] = '.';
                    name[4] = 'j';
                    name[5] = 'p';
                    name[6] = 'g';
                    name[7] = '\0';
                }
                else
                {
                    name[0] = '0';
                    name[1] = '0';
                    name[2] = jpeg + 48;
                    name[3] = '.';
                    name[4] = 'j';
                    name[5] = 'p';
                    name[6] = 'g';
                    name[7] = '\0';

                }
                FILE* pic = fopen(name, "wb");
                int ab = 0;
                while (!(buffer_s[pos + ab + 1] == 0xff && buffer_s[pos + ab + 2] == 0xd8 && buffer_s[pos + ab + 3] == 0xff) && jpeg != 49)
                {
                    ab++;
                }
                if (jpeg == 49)
                {
                    ab = size - pos;
                }
                uint8_t *buffer_t = calloc(ab, 1);
                for (int ba = 0; ba < ab; ba++)
                {
                    buffer_t[ba] = buffer_s[pos + ba];
                }
                fwrite(buffer_t, 1, ab, pic);
                free(buffer_t);
                fclose(pic);
                if (jpeg == 49)
                {
                    a = 0;
                }
                jpeg++;
            }
            pos++;
    }
    free(buffer);
    free(buffer_s);
    fclose(card);
    return 0;
}

