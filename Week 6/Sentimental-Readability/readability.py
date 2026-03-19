def main():
    body = input("Text: ")

    # Total number of sentences in text
    sentences = 0
    sentences += body.count("!") 
    sentences += body.count("?") 
    sentences += body.count(",") 
    sentences += body.count(".")

    # Total number of words in text
    words = body.count(" ") + 1

    # Total number of letters in text
    letters = 0;
    for i in range(len(body)):
        letter = body[i]
        if letter.isalpha() is True:
            letters += 1

    # Compute parameters
    S = (sentences * 100) / words
    L = (letters * 100) / words

    # Calculate Coleman-liau index
    index = (0.0588 * L) - (0.296 * S) - 15.8

    # Output grade
    if index.__round__() < 1:
        print("Before Grade 1")
    elif index.__round__() > 16:
        print("Grade 16+")
    else:
        print("Grade", index.__round__())


main()