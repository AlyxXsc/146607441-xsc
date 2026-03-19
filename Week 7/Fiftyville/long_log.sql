-- Keep a log of any SQL queries you execute as you solve the mystery.
/*
    Case Type: Theft and Escape
    Stolen Item: CS50's Duck
    Starting Leads
        #1: Theft occured on the 28th of July, 2023
        #2: Theft occured on Humphrey Street
    Case Core Points
        #1: Who is the thief?
        #2: What city did the thief escape to?
        #3: Who is the accomplice who helped the thief escape?
*/


-- Log #1: Find out reports about what exactly occured at the crime scene on the day of the incident
/*
    SELECT id,street,description 
    FROM crime_scene_reports 
    WHERE day IS 28
    AND month IS 7
    AND year IS 2023
    AND street IS 'Humphrey Street'
*/
-- Note #1:
/*
    Clues
        #1: Time of occurence is 10:15
        #2: Witnesses are 3 in number, all were present at the time of the theft
        #3: All 3 witnesses have been interviewed
        #4: Each of thier transcripts mentions the bakery
*/


-- Log #2: Look into interview reports, view the suspect count and their data
/*
    SELECT COUNT(id) AS 'Interview Count' 
    FROM interviews
*/


-- Log #3: Look into interview reports of the day of the incident
/*
    SELECT COUNT(id) AS 'Suspect Count' 
    FROM interviews
    WHERE day IS 28
    AND month IS 7
    AND year IS 2023
*/


-- Log #4: Read the transcripts of the interview
/*
    SELECT id,name,day,month,year,transcript 
    FROM interviews
    WHERE day IS 28
    AND month IS 7
    AND year IS 2023
*/
-- Note #2: Witnesses' names are Ruth, Eugene, Raymond with interview IDs 161, 162 & 163 respectively 


-- Log #5: Reopen interview transcript for witness #1 (Ruth)
/*
    SELECT id,name,day,month,year,transcript 
    FROM interviews
    WHERE day IS 28
    AND month IS 7
    AND year IS 2023
    AND id IS 161
*/
-- Note #3: Witness #1's report
/*
    Clues
        #1: Witness claims seeing thief leave the bakery within ten minutes of the theft
        #2: Witness suggests to look at the security footage if there is one 
*/


-- Log #6: Reopen transcript for witness #2 (Eugene)
/*
    SELECT id,name,day,month,year,transcript 
    FROM interviews
    WHERE day IS 28
    AND month IS 7
    AND year IS 2023
    AND id IS 162    
*/
-- Note #4: Witness #2's report
/*
    Clues
        #1: Witness stated that he does not know the thief's name
        #2: Witness claims to have recognized the thief
        #3: Witness claims to have seen the thief withdrawing money at an ATM on Legett Street before the theft
        #4: Witness states he was on Legett Street for a brief amount of time, reason being he took it as a route
            to the bakery
        #5: Witness adresses the bakery owner by name
            Possibility Deductions:
                #1: Witness is a regular at the bakery
                #2: Witness is an acquaintance of the bakery owner
*/


-- Log #7: Reopen transcript for witness #3 (Raymond)
/*
    SELECT id,name,day,month,year,transcript 
    FROM interviews
    WHERE day IS 28
    AND month IS 7
    AND year IS 2023
    AND id IS 163
*/
-- Note #5: Witness #3's report
/*
    Clues
        #1: Witness gives report on the thief's actions as the thief left the bakery
        #2: Witness claims that the thief made a phone call and that the phone call lasted less than a minute
        #3: Witness claims to have heard the thief say on the phone that they were planning to take the earliest 
            flight out of fiftyville the day after
        #4: Witness claims to have heard the thief telling the accomplice to purchase the flight ticket
        #5: Witness used contrasting syntax for flight description, "ticket" not "tickets" 
            even when, according to his report, both the thief and the accomplice intended to take the flight
            Possibility Deductions:
                #1: Witness commited a grammatical blunder
                #2: Thief commited a grammatical blunder
                #3: Only one of the culprits intended to take the flight
                #4: Witness made a false statement  
*/


-- Log #8: Observe Clue #1 from Note #3
    /*
        Sub-log: 
            At Clue #1 from Note #3:
                Witness #1 states to have seen the thief leaving the bakery within 10 minutes of the theft
                when At Clue #1 from Note #1:
                    The theft occured at 10:15
        Motive: Observe the incidents which occured from the bakery security logs from 10:15 - 10:25 
    */
/*
    SELECT id,minute,activity,license_plate
    FROM bakery_security_logs
    WHERE year IS 2023
    AND month IS 7
    AND day IS 28
    AND hour IS 10
    AND minute > 14
    AND minute < 26
*/
-- Note #6: List of licence plate numbers of cars that exited the bakery within 10:15 - 10:25
/*
    Plate Numbers
        #1: 5P2BI95 exit at 10:16
        #2: 94KL13X exit at 10:18
        #3: 6P58WS2 exit at 10:18
        #4: 4328GD8 exit at 10:19
        #5: G412CB7 exit at 10:20
        #6: L93GTIZ exit at 10:21
        #7: 322W7JE exit at 10:23
        #8: ONTHK55 exit at 10:23
*/


-- Log #9: Observe Clue #3 from Note #4
    /*
        Sub-log:
            At Clue #3 from Note #4:
                Witness #2 stated he saw the thief withdrawing money from the ATM on Leggett street before the theft
        Motive
            #1: Observe the incidents which occured on Leggett Street on the day of the theft
            #2: Observe the ATM transactions which took place on that day
            #3: Observe the parties which the transactions were related to
    */
    -- Motive #1:
        /*
            SELECT id,street,description
            FROM crime_scene_reports
            WHERE year IS 2023
            AND month IS 7
            AND day IS 28
            AND street IS 'Leggett Street'
        */
        -- Note: No information on events which occured on Leggett Street on the day of the theft

    -- Motive #2:
        /*
            SELECT id,account_number,amount,transaction_type,atm_location
            FROM atm_transactions
            WHERE year IS 2023
            AND month IS 7
            AND day IS 28
            AND atm_location IS 'Leggett Street'
        */
        -- Note #7: Found a detailed list of atm_transactions which occured on the day of theft
            /*
                Transactions
                    #1: $48 was withdrawn from 28500762
                    #2: $20 was withdrawn from 28296815
                    #3: $60 was withdrawn from 76054385
                    #4: $50 was withdrawn from 49610011
                    #5: $80 was withdrawn from 16153065
                    #6: $10 was deposited into 86363979
                    #7: $20 was withdrawn from 25506511
                    #8: $30 was withdrawn from 81061156
                    #9: $35 was withdrawn from 26013199
            */

    -- Motive #3:
        -- For withdrawals
        /*
            SELECT *
            FROM people
            WHERE id IN (
                SELECT person_id
                FROM bank_accounts
                WHERE account_number IN (
                    SELECT account_number
                    FROM atm_transactions
                    WHERE atm_location IS 'Leggett Street'
                    AND year IS 2023
                    AND month IS 7
                    AND day IS 28
                    AND transaction_type IS 'withdraw'
                )
            )
        */
        -- For deposits
        /*
            SELECT *
            FROM people
            WHERE id IN (
                SELECT person_id
                FROM bank_accounts
                WHERE account_number IN (
                    SELECT account_number
                    FROM atm_transactions
                    WHERE atm_location IS 'Leggett Street'
                    AND year IS 2023
                    AND month IS 7
                    AND day IS 28
                    AND transaction_type IS 'deposit'
                )
            )
        */
    -- Note #7: Found a total of 9 suspects and their profiles in database
        /*
            Suspects
                #1:
                    Name: Kaelyn
                    Phone Number: (098) 555-1164
                    Passport Number: 8304650265 
                    License Plate: I449449
                    Transaction Type: DeposIt

                #2:
                    Name: Kenny
                    Phone Number: (826) 555-1652
                    Passport Number: 9878712108
                    License Plate: 30G67EN
                    Transaction Type: Withdrawal 

                #3:
                    Name: Iman
                    Phone Number: (829) 555-5269
                    Passport Number: 7049073643
                    License Plate: L93JTIZ
                    Transaction Type: Withdrawal 

                #4:
                    Name: Benista
                    Phone Number: (338) 555-6650
                    Passport Number: 9586786673
                    License Plate: 8X428L0
                    Transaction Type: Withdrawal 

                #5:
                    Name: Taylor
                    Phone Number: (286) 555-6063
                    Passport Number: 1988161715
                    License Plate: 1106N58
                    Transaction Type: Withdrawal 

                #6:
                    Name: Brooke
                    Phone Number: (122) 555-4581
                    Passport Number: 4408372428
                    License Plate: QX4YZN3
                    Transaction Type: Withdrawal 

                #7:
                    Name: Luca
                    Phone Number: (389) 555-5198
                    Passport Number: 8496433585
                    License Plate: 4328GD8
                    Transaction Type: Withdrawal 

                #8:
                    Name: Diana
                    Phone Number: (770) 555-1861
                    Passport Number: 3592750733
                    License Plate: 322W7JE
                    Transaction Type: Withdrawal 

                #9:
                    Name: Bruce
                    Phone Number: (367) 555-5533
                    Passport Number: 5773159633
                    License Plate: 94KL13X
                    Transaction Type: Withdrawal         
        */


-- Log #10: Find out which of the suspects left the bakery at the time specified by witness #1
/*
    SELECT *
    FROM people
    WHERE id IN (
        SELECT id
        FROM people
        WHERE license_plate IN (
            SELECT license_plate
            FROM bakery_security_logs
            WHERE activity IS 'exit'
            AND year IS 2023
            AND month IS 7
            AND day IS 28
            AND hour IS 10
            AND minute > 14
            AND minute < 26
        )
        AND license_plate IN (
            SELECT license_plate 
            FROM people
            WHERE id IN (
                SELECT person_id
                FROM bank_accounts
                WHERE account_number IN (
                    SELECT account_number
                    FROM atm_transactions
                    WHERE atm_location IS 'Leggett Street'
                    AND year IS 2023
                    AND month IS 7
                    AND day IS 28
                )
            )
        )
    )
*/
-- Note #8: Out of 9 suspects from the bank, 4 were present at the bakery
    /*
        Suspects who where present at the bakery
            #1: Iman
            #2: Luca
            #3: Diana
            #4: Bruce
    */


-- Log #11: Observe Clue #2 from Note #5
/*
    Sub-log:
        Witness #3 claimed the thief made a phone call that lasted less than a minute
    Motive: Find out which out of the four suspects made a phone call at the bakery
*/
/*
    SELECT *
    FROM people
    WHERE phone_number IN (
        SELECT caller
        FROM phone_calls
        WHERE duration < 60
        AND caller IN (
            SELECT phone_number
            FROM people
            WHERE license_plate IN (
                SELECT license_plate
                FROM bakery_security_logs
                WHERE activity IS 'exit'
                AND year IS 2023
                AND month IS 7
                AND day IS 28
                AND hour IS 10
                AND minute > 14
                AND minute < 26
            )
            AND license_plate IN (
                SELECT license_plate 
                FROM people
                WHERE id IN (
                    SELECT person_id
                    FROM bank_accounts
                    WHERE account_number IN (
                        SELECT account_number
                        FROM atm_transactions
                        WHERE atm_location IS 'Leggett Street'
                        AND year IS 2023
                        AND month IS 7
                        AND day IS 28
                    )
                )
            )
        )
    )
*/
-- Note #9: Out of 4 suspects, two made a phone call each which lasted less than a minute
    /*
        Suspects who made a phone call with duration less than a minute
            #1: Diana
            #2: Bruce
    */


-- Log #12: Observe Clue #3 from Note #5
/*
    Sub-log: 
        At Clue #3 from Note #5: 
            Witness claimed the thief intended to take the earliest flight out of the city the next day
    Motive: Search for which of the suspects took the earliest flight the next day
*/
/*
    SELECT name 
    FROM people
    WHERE passport_number IN (
        SELECT passport_number
        FROM passengers
        WHERE flight_id IN (
            SELECT id
            FROM flights
            WHERE origin_airport_id IN (
                SELECT id
                FROM airports
                WHERE city IS 'Fiftyville'
            )
            AND year IS 2023
            AND month IS 7
            AND day IS 29
            AND hour IN (
                SELECT hour
                FROM flights
                WHERE origin_airport_id IN (
                    SELECT id 
                    FROM airports 
                    WHERE city IS 'Fiftyville'
                )
                AND year IS 2023
                AND month IS 7
                AND day IS 29
                ORDER BY hour
                LIMIT 1
            )
            AND minute IN (
                SELECT minute
                FROM flights
                WHERE origin_airport_id IN (
                    SELECT id
                    FROM airports
                    WHERE city IS 'Fiftyville'
                )
                AND year IS 2023
                AND month IS 7
                AND day IS 29
                AND hour IN (
                    SELECT hour
                    FROM flights
                    WHERE origin_airport_id IN (
                        SELECT id 
                        FROM airports 
                        WHERE city IS 'Fiftyville'
                    )
                    AND year IS 2023
                    AND month IS 7
                    AND day IS 29
                    ORDER BY hour
                    LIMIT 1
                )
                ORDER BY minute
                LIMIT 1
            )
        )
    )
    AND name IN (
        SELECT name
        FROM people
        WHERE phone_number IN (
            SELECT caller
            FROM phone_calls
            WHERE duration < 60
            AND caller IN (
                SELECT phone_number
                FROM people
                WHERE license_plate IN (
                    SELECT license_plate
                    FROM bakery_security_logs
                    WHERE activity IS 'exit'
                    AND year IS 2023
                    AND month IS 7
                    AND day IS 28
                    AND hour IS 10
                    AND minute > 14
                    AND minute < 26
                )
                AND license_plate IN (
                    SELECT license_plate 
                    FROM people
                    WHERE id IN (
                        SELECT person_id
                        FROM bank_accounts
                        WHERE account_number IN (
                            SELECT account_number
                            FROM atm_transactions
                            WHERE atm_location IS 'Leggett Street'
                            AND year IS 2023
                            AND month IS 7
                            AND day IS 28
                        )
                    )
                )
            )
        )
    )
*/
    -- Note #10: According to the query, Bruce took the earliest flight out of Fiftyville the next day
        /*
            Deduction:
                The identity of the thief is Bruce
        */
        -- Core point 1/3 solved


-- Log #13: Find out what city the thief (Bruce) escaped to
/*
    SELECT city
    FROM airports
    WHERE id IN (
        SELECT destination_airport_id
        FROM flights
        WHERE id IN (
            SELECT flight_id
            FROM passengers
            WHERE passport_number IN (
                SELECT passport_number
                FROM people 
                WHERE id IN (
                    SELECT id 
                    FROM people
                    WHERE name = 'Bruce'
                )
            )
        )
    )
*/
    -- Note #11: According to the query, the destination of Bruce's flight is New York City
        /*
            Deduction:
                Bruce, the thief escaped to New York City
        */
        -- Core point 2/3 solved


-- Log #14: Find out who the thief's accomplice is
    /*
        Sub-log: 
            At Clue #4 from Note #5:
                Witness #3 claimed the thief made a phone call with the accomplice at the bakery, 
                telling them to purchase the earliest flight ticket out of fiftyville
        Deduction: The accomplice is whoever Bruce had a phone call with at the bakery
        Motive: Find out the identity of the person who was on the recieving end of Bruce's Call at the bakery
    */
/*
    SELECT *
    FROM people 
    WHERE phone_number IN (
        SELECT receiver
        FROM phone_calls
        WHERE caller IN (
            SELECT phone_number
            FROM people
            WHERE name IS 'Bruce'
        )
        AND year IS 2023
        AND month IS 7
        AND day IS 28
        AND duration < 60
    )
*/
    -- Note #12: According to the query, 
    --        the identity of the one on the revieving end of Bruce's call is a person named Robin
    -- Deduction: The identity of the thief's (Bruce) accomplice is a person named Robin
    -- Core point 3/3 solved


-- Conclusion: CASE CLOSED 