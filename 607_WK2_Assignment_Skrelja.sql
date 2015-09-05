-- 607 Data Acquisition & Management
-- WK2 Assignment: SQL and NULLs
-- Randi Skrelja
-- 9/6/15

-- 1. How many airplanes have listed speeds? [ANSWER: 23] 
--    What is the minimum listed speed and the maximum listed speed? [ANSWER: 90 MIN, 432 MAX]

SELECT COUNT(*) FROM planes WHERE speed > 0;
SELECT speed FROM planes WHERE speed > 0 ORDER BY speed ASC LIMIT 1;
SELECT speed FROM planes WHERE speed > 0 ORDER BY speed DESC LIMIT 1;

-- 2. What is the total distance flown by all of the planes in January 2013? [ANSWER: 27,188,805]
--    What is the total distance flown by all of the planes in January 2013 where the tailnum is missing? [81,763]

SELECT SUM(distance) FROM flights WHERE year = 2013 AND month = 1;
SELECT SUM(distance) FROM flights WHERE tailnum IS NULL AND year = 2013 AND month = 1;

-- 3. What is the total distance flown for all planes on July 5, 2013 grouped by aircraft manufacturer?
--    Write this statement first using an INNER JOIN, then using a LEFT OUTER JOIN.
--    How do your results compare? [ANSWER: Same results]

SELECT manufacturer, SUM(distance) FROM flights
JOIN planes ON flights.tailnum=planes.tailnum 
WHERE manufacturer IS NOT NULL AND distance IS NOT NULL AND flights.year = 2013 AND month = 7 AND day = 5
GROUP BY manufacturer ORDER BY SUM(distance) DESC;

SELECT manufacturer, SUM(distance) FROM flights
LEFT JOIN planes ON flights.tailnum=planes.tailnum 
WHERE manufacturer IS NOT NULL AND distance IS NOT NULL AND flights.year = 2013 AND month = 7 AND day = 5
GROUP BY manufacturer ORDER BY SUM(distance) DESC;

-- 4. Write and answer at least one question of your own choosing that joins information from at least three of the tables
--    in the flights database.
--    Which engine from Delta Airlines has the most departure delays on average? [ANSWER: Turbo-jet]

SELECT engine, AVG(dep_delay) FROM flights
JOIN planes ON flights.tailnum=planes.tailnum 
JOIN airlines ON flights.carrier=airlines.carrier
WHERE engine IS NOT NULL AND dep_delay IS NOT NULL AND name LIKE '%Delta%'
GROUP BY engine ORDER BY AVG(dep_delay) DESC