// Implements a dictionary's functionality

#include <ctype.h>
#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/stat.h>
#include "dictionary.h"

// Represents a node in a hash table
typedef struct node
{
    char *word;
    struct node *next;
} node;

void empty_node(node *target);

// TODO: Choose number of buckets in hash table
#define N 26

// Hash table
node *table[N];

int words_loaded = 0;
int block = sizeof(node);

int init()
{
    for (int i = 0; i < N; i++)
    {
        table[i] = malloc(block);
        table[i]->word = calloc(LENGTH + 1, 1);
        table[i]->word[0] = '\0';
        table[i]->next = NULL;
    }
    return 0;
}

// Returns true if word is in dictionary, else false
bool check(const char *word)
{
    // TODO
    //Clone word
    char* sub = calloc(strlen(word) + 1, 1);
    strcpy(sub, word);
    sub[strlen(word)] = '\0';

    //Converts clone to all lowercase
    for (int i = 0; i < strlen(word); i++)
    {
        char c = sub[i];
        if (isalpha(c))
        {
            if (isupper(c))
            {
                tolower(c);
                sub[i] = c;
            }
        }
    }

    //Finds hash of clone
    unsigned int slot = hash(sub);

    //Moves to bucket in hash table
    node *curr = malloc(block);
    *curr = *(table[slot]);
    //Compares strings, returns true if same
    if (strcmp(table[slot]->word, sub) == 0)
    {
        free(curr);
        return true;
    }

    //Iterates to the final node, comparing the words in buckets
    else
    {
        node *tmp = malloc(block);
        *tmp = *(table[slot]);
        if (tmp->next != NULL)
        {
            while (tmp->next != NULL)
            {
                //Swap nodes
                node *tmp2 = malloc(block);
                *tmp2 = *(tmp->next);
                *tmp = *tmp2;
                free(tmp2);

                //Returns true on match
                if (strcmp(tmp->word, sub) == 0)
                {
                    return true;
                }
            }
        }
        free(tmp);
    }
    free(curr);
    return false;
}

// Hashes word to a number
unsigned int hash(const char *word)
{
    // TODO: Improve this hash function 
    if (word[0] == 0)
    {
        return 0;
    }
    int y = word[0];
    while (y > 26)
    {
        y%=26;
    }
    return y;
}

// Loads dictionary into memory, returning true if successful, else false
bool load(const char *dictionary)
{
    // TODO
    // Opens dictionary file for reading
    FILE* source = fopen(dictionary, "rb");
    if (source == NULL)
    {
        return false;
    }
    struct stat fd;

    // Reads words into a buffer
    stat(dictionary, &fd);
    int size = fd.st_size;
    char* buffer = calloc(size + 1, 1);
    fread(buffer, 1, size, source);

    //Creates space in buckets
    init();

    //Read words from dictionary into a multidimensional array
    //Count words in buffer
    int x = 0;
    int y = LENGTH + 1;
    for (int i = 0; i < size; i++)
    {
        if (buffer[i] == '\n' || buffer[i] == '\0' || buffer[i] == EOF)
        {
            x++;
        }
    }
    int count = x;

    //Create space for list of words
    char *list[x];
    for (int i = 0; i < x; i++)
    {
        list[i] = calloc(y, 1);
    }

    //Copy words from buffer into list
    x = 0;
    y = 0;
    for (int i = 0; i < size; i++)
    {
        list[x][y] = buffer[i];
        if (buffer[i] == '\n')
        {
            buffer[i] = '\0';
            list[x][y] = buffer[i];
            y = 0;
            x++;
        }
            y++;
    }

    // Reads words into hash table
    for (int i = 0; i < count; i++)
    {
        //Checks if node bucket is empty, copies word if true
        unsigned int slot = hash(list[i]);
        if (strlen(table[slot]->word) < 1)
        {
            strcpy(table[slot]->word, list[i]);
            words_loaded++;
        }

        //Checks if next node is empty, creates and copies word if true
        else
        {
            if (table[slot]->next == NULL)
            {
                table[slot]->next = malloc(block);
                node *curr = malloc(block);
                curr->word = calloc(LENGTH + 1, 1);
                curr->next = NULL;
                strcpy(curr->word, list[i]);
                *(table[slot]->next) = *curr;
                free(curr);
                words_loaded++;
            }

            //Checks if succeeding node exists, creates and copies word into bucket if not 
            else
            {
                node *curr = malloc(block);
                *curr = *(table[slot]->next);
                if (curr->next == NULL)
                {
                    node *tmp = malloc(block);
                    tmp->word = calloc(LENGTH + 1, 1);
                    strcpy(tmp->word, list[i]);
                    tmp->next = NULL;
                    words_loaded++;
                }

                //Iterates to the end of node if succeeding nodes exist
                else
                {
                    while (curr->next != NULL)
                    {
                        node *tmp = malloc(block);
                        *tmp = *(curr->next);

                        //Creates and copies word into node at the end of the list
                        if (tmp->next == NULL)
                        {
                            tmp->next = malloc(block);
                            node *tmp2 = malloc(block);
                            *tmp2 = *(tmp->next);
                            *tmp = *tmp2;
                            free(tmp2);
                            tmp->word = calloc(LENGTH + 1, 1);
                            strcpy(tmp->word, list[i]);
                            tmp->next = NULL;
                            words_loaded++;
                            *curr = *tmp;
                        }
                        else
                        {
                            node *tmp2 = malloc(block);
                            *tmp2 = *(tmp->next);
                            *tmp = *tmp2;
                            free(tmp2);
                        }
                        *curr = *tmp;
                        free(tmp);
                    }
                }
                free(curr);
            }
        }
    }

    // Closes dictionary file after use
    free(buffer);
    fclose(source);
    return true;
}

// Returns number of words in dictionary if loaded, else 0 if not yet loaded
unsigned int size(void)
{
    // Return total words loaded in memory
    return words_loaded;
}

// Unloads dictionary from memory, returning true if successful, else false
bool unload(void)
{
    // TODO
    // Iterate through the hash tables
    for (int i = 0; i < N; i++)
    {
        if (table[i]->next == NULL)
        {
            free(table[i]->word);
            free(table[i]);
        }
        else
        {
            empty_node(table[i]->next);
            free(table[i]->word);
            free(table[i]);
        }
    }
    return true;
}

void empty_node(node *target)
{
    if (target->next == NULL)
    {
        free(target->word);
        free(target);
    }
    else
    {
        node *curr = malloc(block);
        while (target->next != NULL)
        {
            node *tmp = malloc(block);
            *tmp = *(curr->next);
            if (tmp->next == NULL)
            {
                empty_node(tmp);
                empty_node(curr->next);
            }
            *curr = *tmp;
            free(tmp);
        }
        free(curr);
    }
    return;
}