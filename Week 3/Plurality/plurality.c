#include <cs50.h>
#include <ctype.h>
#include <stdio.h>
#include <string.h>

// Max number of Candidates.
#define MAX 9

// Candidates Have Name And Votes
typedef struct
{
    int votes;
    string name;
} candidate;

// Number Of Candidates
int candidate_count;

// Array Of Candidates
candidate candidates[MAX];

bool vote(char name[]);

void print_winner(void);

int main(int argc, string argv[])
{

    // Populate array of candidates
    candidate_count = argc - 1;
    if (candidate_count > MAX)
    {
        printf("Maximum number of candidates is %i\n", MAX);
        return 1;
    }
    for (int i = 0; i < candidate_count; i++)
    {
        candidates[i].votes = 0;
        int a = 0;
        // printf("%p\n", &argv[i]);
        while (argv[i + 1][a] != 0)
        {
            a++;
        }
        for (int x = 0; x <= a; x++)
        {
            strcpy(candidates[i].name, argv[i + 1]);
            // printf("candidate[%d].name[%d] = %d ", i, x, candidate[i].name[x]);
        }
        // printf("\n%s\n\n",candidate[i].name);
    }

    // Prompt user for number of voters
    int voters = get_int("Number of voters: ");
    if (voters == 0)
    {
        printf("Invalid Ballot Size\n");
        return 1;
    }
    char voted[voters][100];
    for (int a = 0; a < voters; a++)
    {
        string voted_tmp = get_string("Vote: ");
        strcpy(voted[a], voted_tmp);
        if (voted[a][0] == 0)
        {
            a--;
        }
        // printf("Voted Is %s\n", voted[a]);
        else if (vote(voted[a]) == false)
        {
            printf("Invalid Participant!\n");
            a--;
        }
    }
    print_winner();
    return 0;
}

// Update vote totals given a new vote
bool vote(char name[])
{
    int x = 0;
    while (x < candidate_count)
    {
        // printf("Candidate [0%d] is %s\n",x,candidate[x].name);
        x++;
    }
    x = 0;
    while (x < candidate_count)
    {
        int t = 0;
        int vol = strlen(candidates[x].name) + strlen(name) + 1;
        char temp[2][vol];
        while (candidates[x].name[t] != 0)
        {
            temp[0][t] = candidates[x].name[t];
            if (isupper(temp[0][t]))
            {
                temp[0][t] = temp[0][t] + 32;
            }
            t++;
        }
        temp[0][t] = 0;
        t = 0;
        while (name[t] != 0)
        {
            temp[1][t] = name[t];
            if (isupper(temp[1][t]))
            {
                temp[1][t] = temp[1][t] + 32;
            }
            t++;
        }
        temp[1][t] = 0;
        // printf("Process[0%d] Comparing %s & %s\n",x,candidate[x].name,name);
        if (strcmp(temp[0], temp[1]) == 0)
        {
            candidates[x].votes++;
            // printf("%s's votes are %d now\n",candidate[x].name,candidate[x].votes);
            return true;
        }
        x++;
    }
    return false;
}

void print_winner(void)
{
    // Find the maximum number of votes
    int v = 0;
    int votes[candidate_count];
    for (int i = 0; i <= candidate_count; i++)
    {
        votes[i] = 0;
        votes[i] = candidates[i].votes;
        v = v + votes[i];
    }

    int i = 0;
    int a = 1;
    int rec = 0;
    int winner_count = 0;
    int winners[candidate_count + 1];
    for (int x = 0; x <= candidate_count; x++)
    {
        winners[x] = 0;
    }
    while (a == 1)
    {
        // printf("%d Votes Left\n", v);
        if (votes[i] > rec)
        {
            rec = votes[i];
            winner_count = 0;
            winners[winner_count] = i;
            // printf("Leading Candidate is %s\n", candidate[i].name);
            winner_count++;
        }
        else if (votes[i] == rec)
        {
            winners[winner_count] = i;
            // printf("Also %s\n", candidate[i].name);
            winner_count++;
        }
        if (v == 0)
        {
            // printf("Winners are %d\n", winner_count);
            a = 0;
        }
        v = v - votes[i];
        i++;
    }
    int c = 0;
    while (winners[c] != 0)
    {
        if (winners[c] >= candidate_count)
        {
            winners[c]--;
        }
        // printf("%d  ", winners[c]);
        c++;
    }
    // Print the candidate (or candidates) with maximum votes
    if (winner_count == 1)
    {
        i = winners[0];
        printf("%s\n", candidates[i].name);
    }
    else
    {
        for (int x = 0; x < winner_count; x++)
        {
            i = winners[x];
            printf("%s\n", candidates[i].name);
        }
    }
    return;
}
