x = int(input("Change owed: "))
coins = 1
quarter = 25
ten_cent = 10
five_cent = 5
cent = 1

if x > quarter:
    while x > quarter:
        x -= quarter
        coins += 1

if x > ten_cent:
    while x > ten_cent:
        x -= ten_cent
        coins += 1

if x > five_cent:
    while x > five_cent:
        x -= five_cent
        coins += 1

if x > cent:
    while x > cent:
        x -= cent
        coins += 1

print(coins)