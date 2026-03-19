def main():
    x = int(input("Height: "))
    for i in range(x):
        print_spaces(x - i)
        print_blocks(i + 1)
        print("  ", end = "")
        print_blocks(i + 1)
        print()


def print_blocks(x):
    for i in range(x):
        print("#", end = "")


def print_spaces(y):
    for i in range(y):
        print(" ", end = "")


main()