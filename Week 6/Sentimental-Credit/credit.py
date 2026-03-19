def main():
    # Prompt user for a number
    number = input("Number: ")

    # Copies number into array
    arr = []
    chksum = []
    l = len(number)
    for i in range(l):
        digit = int(number[i])
        arr.append(digit)
        chksum.append(digit)

    # Calculates the values for the checksum
    x = l - 2
    while x >= 0:
        if chksum[x] > 4:
            prod = chksum[x] * 2
            chksum[x] = (prod % 10) + 1
        else:
            chksum[x] *= 2
        x -= 2

    # Adds up the checksum
    sum = 0
    for i in range(l):
        sum += chksum[i]

    # Checks if checksum is valid, prints invalid if otherwise
    if (sum % 10) == 0:
        # Prints name of card pattern number matches
        a = arr[0]
        b = arr[1]
        if amex(l, a, b) is True:
            print("AMEX")
        elif mastercard(l, a, b) is True:
            print("MASTERCARD")
        elif visa(l, a) is True:
            print("VISA")
        else:
            print("INVALID1")
    else:
        print("INVALID2")


# Checks if number matches Amex and returns true, false if otherwise
def  amex(len, x, y):
    if len == 15:
        if x == 3:
            if y == 4 or y == 7:
                return True
    return False


# Checks if number matches Mastercard and returns true, false if otherwise
def mastercard(len, x, y):
    if len == 16:
        if x == 5:
            if y >= 1 and y <= 5:
                return True
    return False


# Checks if number matches Visa and returns true, false if otherwise
def visa(len, x):
    if len == 13 or len == 16:
        if x == 4:
            return True
    return False


main()