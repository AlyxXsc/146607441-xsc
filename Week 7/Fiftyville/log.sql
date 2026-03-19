-- Keep a log of any SQL queries you execute as you solve the mystery.

-- Log #1: Find reports about what exactly occured  at the crime scene on the day of the theft
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


-- Log #2: Find the transcript ID of  interviewed witnesses
/*
    SELECT id,name,day,month,year,transcript 
    FROM interviews
    WHERE day IS 28
    AND month IS 7
    AND year IS 2023
*/
-- Note #2: Found Transcript ID for all 3 witnesses


-- Log #3: Open interview transcript for witness #1
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


-- Log #4: Open transcript for witness #2 
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
        #2: Witness claimed to have recognized the thief
        #3: Witness claimed to have seen the thief withdrawing money at an ATM on Legett Street before the theft
        #4: Witness states he was on Legett Street for a brief amount of time, reason being he took it as a route
            to the bakery
*/


-- Log #5: Open transcript for witness #3 
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
        #1: Witness claimed that the thief made a phone call and that the phone call lasted less than a minute
        #2: Witness claimed to have heard the thief say on the phone that they were planning to take the earliest 
            flight out of fiftyville the day after
        #3: Witness claimed to have heard the thief telling the accomplice to purchase the flight ticket
*/


-- Log #6: Observe Clue #1 from Note #3
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
-- Note #6: Found list of licence plate numbers of cars that exited the bakery within 10:15 - 10:25


-- Log #7: Observe Clue #3 from Note #4
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
        -- Note #7: Found a detailed list of 9 atm_transactions which occured on the day of theft. 

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
    -- Note #7: Found a total of 9 suspects and their profiles in database.


-- Log #8: Find out which of the suspects left the bakery at the time specified by witness #1
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
-- Note #8: Found 4 out of 9 suspects from the bank, who were present at the bakery.


-- Log #9: Observe Clue #2 from Note #5
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
-- Note #9: Found out of 4 suspects, two who made a phone call each which lasted less than a minute.


-- Log #10: Observe Clue #3 from Note #5
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


-- Log #11: Find out what city the thief, Bruce escaped to
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


-- Log #12: Find out who the thief's accomplice is
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
    -- Deduction: The identity of the thief, Bruce's accomplice is a person named Robin
    -- Core point 3/3 solved


-- Conclusion: CASE CLOSED 