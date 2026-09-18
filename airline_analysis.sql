create database flight;

select * from flight.flights_sample_3m;

select count(*) as total_rows from flight.flights_sample_3m;

describe flight.flights_sample_3m;

select * from flight.flights_sample_3m limit 10;

select AIRLINE, count(*) as airline_count from  flight.flights_sample_3m group by AIRLINE;

select AIRLINE, count(*) as airline_count from  flight.flights_sample_3m group by AIRLINE order by airline_count desc;

select ORIGIN, count(*) as origin_departed from  flight.flights_sample_3m group by ORIGIN;

select ORIGIN, count(*) as highest_departed from flight.flights_sample_3m group by ORIGIN ORDER BY highest_departed desc;

select DEST, count(*) as arrived from flight.flights_sample_3m group by DEST;

select DEST, count(*) as arrived from flight.flights_sample_3m group by DEST ORDER BY arrived desc;

select AIRLINE, avg(DEP_DELAY) as highest_depart from flight.flights_sample_3m group by AIRLINE order by highest_depart desc;

select AIRLINE, avg(ARR_DELAY) as highest_depart from flight.flights_sample_3m group by AIRLINE order by highest_depart desc;

select AIRLINE,count(*) as cancellation_count  from flight.flights_sample_3m  where CANCELLED = 1 
group by AIRLINE order by cancellation_count desc; 

select CANCELLED, count(*) as flight_count from flight.flights_sample_3m  group by CANCELLED order by CANCELLED desc;

select count(*) as heavily_delayed_flights from flight.flights_sample_3m where DEP_DELAY > 60;

select count(*) as heavily_delayed_flights from flight.flights_sample_3m where ARR_DELAY > 60;

select ORIGIN , DEST , count(*) as flight_count from flight.flights_sample_3m group by ORIGIN ,
 DEST order by flight_count DESC LIMIT 10;
 
 
 SELECT AIRLINE,
 ROUND(AVG(DEP_DELAY), 2) AS avg_departure_delay
FROM flight.flights_sample_3m
GROUP BY AIRLINE
ORDER BY avg_departure_delay DESC;

SELECT AIRLINE,
ROUND(AVG(ARR_DELAY), 2) AS avg_arrival_delay
FROM flight.flights_sample_3m
GROUP BY AIRLINE
ORDER BY avg_arrival_delay DESC;

SELECT AIRLINE,
COUNT(*) AS severe_delay_flights
FROM flight.flights_sample_3m
WHERE DEP_DELAY > 60
GROUP BY AIRLINE
ORDER BY severe_delay_flights DESC;

SELECT AIRLINE,
       COUNT(*) AS on_time_flights
FROM flight.flights_sample_3m
WHERE DEP_DELAY <= 0
GROUP BY AIRLINE
ORDER BY on_time_flights DESC;

SELECT AIRLINE,
       ROUND(AVG(DISTANCE), 2) AS avg_distance
FROM flight.flights_sample_3m
GROUP BY AIRLINE
ORDER BY avg_distance DESC;

SELECT AIRLINE,
       ROUND(AVG(AIR_TIME), 2) AS avg_air_time
FROM flight.flights_sample_3m
GROUP BY AIRLINE
ORDER BY avg_air_time DESC;

SELECT AIRLINE, FL_NUMBER, ORIGIN, DEST, DISTANCE
FROM flight.flights_sample_3m
ORDER BY DISTANCE DESC LIMIT 10;

SELECT
    AIRLINE,
    FL_NUMBER,
    DEP_DELAY,
    CASE
        WHEN DEP_DELAY IS NULL THEN 'No Data'
        WHEN DEP_DELAY <= 0 THEN 'On Time'
        WHEN DEP_DELAY <= 30 THEN 'Minor Delay'
        WHEN DEP_DELAY <= 60 THEN 'Moderate Delay'
        ELSE 'Severe Delay'
    END AS delay_category
FROM flight.flights_sample_3m;

SELECT
    CASE
        WHEN DEP_DELAY IS NULL THEN 'No Data'
        WHEN DEP_DELAY <= 0 THEN 'On Time'
        WHEN DEP_DELAY <= 30 THEN 'Minor Delay'
        WHEN DEP_DELAY <= 60 THEN 'Moderate Delay'
        ELSE 'Severe Delay'
    END AS delay_category,
    COUNT(*) AS flight_count
FROM flight.flights_sample_3m
GROUP BY delay_category
ORDER BY flight_count DESC;

SELECT
    AIRLINE,
    ROUND(AVG(DEP_DELAY), 2) AS avg_departure_delay,
    RANK() OVER (
        ORDER BY AVG(DEP_DELAY) DESC
    ) AS delay_rank
FROM flight.flights_sample_3m
GROUP BY AIRLINE;

SELECT
    ORIGIN,
    DEST,
    COUNT(*) AS flight_count,
    RANK() OVER (
        ORDER BY COUNT(*) DESC
    ) AS route_rank
FROM flight.flights_sample_3m
GROUP BY ORIGIN, DEST
LIMIT 10;

SELECT
    ROUND(
        100.0 * SUM(CASE WHEN DEP_DELAY > 0 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS delayed_flight_percentage
FROM flight.flights_sample_3m;


SELECT
    ROUND(
        100.0 * SUM(CASE WHEN DEP_DELAY <= 0 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS on_time_percentage
FROM flight.flights_sample_3m;

SELECT
    AIRLINE,
    COUNT(*) AS total_flights,
    ROUND(AVG(DEP_DELAY), 2) AS avg_departure_delay,
    ROUND(AVG(ARR_DELAY), 2) AS avg_arrival_delay,
    ROUND(
        100 * SUM(CASE WHEN DEP_DELAY <= 0 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS on_time_percentage
FROM flight.flights_sample_3m
GROUP BY AIRLINE
ORDER BY avg_departure_delay DESC;

SELECT
    ORIGIN,
    DEST,
    COUNT(*) AS total_flights,
    ROUND(AVG(DEP_DELAY), 2) AS avg_departure_delay,
    ROUND(AVG(ARR_DELAY), 2) AS avg_arrival_delay,
    ROUND(AVG(DISTANCE), 2) AS avg_distance
FROM flight.flights_sample_3m
GROUP BY ORIGIN, DEST
ORDER BY total_flights DESC
LIMIT 20;

SELECT
    AIRLINE,
    ROUND(AVG(DEP_DELAY), 2) AS avg_departure_delay,
    ROUND(AVG(ARR_DELAY), 2) AS avg_arrival_delay,
    ROUND(AVG(ARR_DELAY - DEP_DELAY), 2) AS avg_delay_change
FROM flight.flights_sample_3m
GROUP BY AIRLINE
ORDER BY avg_delay_change DESC;

SELECT
    AIRLINE,
    COUNT(*) AS total_flights,
    SUM(CASE WHEN CANCELLED = 1 THEN 1 ELSE 0 END) AS cancelled_flights,
    ROUND(
        100 * SUM(CASE WHEN CANCELLED = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS cancellation_percentage
FROM flight.flights_sample_3m
GROUP BY AIRLINE
ORDER BY cancellation_percentage DESC;

SELECT
    AIRLINE,
    COUNT(*) AS total_flights,
    SUM(CASE WHEN DIVERTED = 1 THEN 1 ELSE 0 END) AS diverted_flights,
    ROUND(
        100 * SUM(CASE WHEN DIVERTED = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS diversion_percentage
FROM flight.flights_sample_3m
GROUP BY AIRLINE
ORDER BY diversion_percentage DESC;

SELECT
    SUM(AIRLINE_DELAY) AS airline_delay,
    SUM(WEATHER_DELAY) AS weather_delay,
    SUM(NAS_DELAY) AS nas_delay,
    SUM(SECURITY_DELAY) AS security_delay,
    SUM(LATE_AIRCRAFT_DELAY) AS late_aircraft_delay
FROM flight.flights_sample_3m;

SELECT
    ORIGIN,
    COUNT(*) AS total_flights,
    ROUND(AVG(DEP_DELAY), 2) AS avg_departure_delay,
    ROUND(AVG(ARR_DELAY), 2) AS avg_arrival_delay
FROM flight.flights_sample_3m
GROUP BY ORIGIN
ORDER BY avg_departure_delay DESC
LIMIT 20;

SELECT
    DEST,
    COUNT(*) AS total_flights,
    ROUND(AVG(DEP_DELAY), 2) AS avg_departure_delay,
    ROUND(AVG(ARR_DELAY), 2) AS avg_arrival_delay
FROM flight.flights_sample_3m
GROUP BY DEST
ORDER BY avg_arrival_delay DESC
LIMIT 20;

SELECT
    MONTH(FL_DATE) AS flight_month,
    COUNT(*) AS total_flights,
    ROUND(AVG(DEP_DELAY), 2) AS avg_departure_delay,
    ROUND(AVG(ARR_DELAY), 2) AS avg_arrival_delay
FROM flight.flights_sample_3m
GROUP BY MONTH(FL_DATE)
ORDER BY flight_month;

SELECT
    ORIGIN,
    DEST,
    ROUND(AVG(DISTANCE), 2) AS avg_distance,
    COUNT(*) AS total_flights,
    ROUND(AVG(AIR_TIME), 2) AS avg_air_time
FROM flight.flights_sample_3m
GROUP BY ORIGIN, DEST
ORDER BY avg_distance DESC
LIMIT 20;

SELECT
    CASE
        WHEN DEP_DELAY <= 0 THEN 'On Time'
        ELSE 'Delayed'
    END AS flight_status,
    COUNT(*) AS total_flights,
    ROUND(100 * COUNT(*) / (SELECT COUNT(*) FROM flight.flights_sample_3m), 2)
        AS percentage
FROM flight.flights_sample_3m
GROUP BY flight_status;

SELECT
    AIRLINE,
    ROUND(AVG(TAXI_OUT), 2) AS avg_taxi_out,
    ROUND(AVG(TAXI_IN), 2) AS avg_taxi_in,
    ROUND(AVG(TAXI_OUT + TAXI_IN), 2) AS avg_total_taxi_time
FROM flight.flights_sample_3m
GROUP BY AIRLINE
ORDER BY avg_total_taxi_time DESC;

SELECT
    AIRLINE,
    COUNT(*) AS total_flights,
    ROUND(AVG(AIR_TIME), 2) AS avg_air_time,
    ROUND(AVG(ELAPSED_TIME), 2) AS avg_elapsed_time
FROM flight.flights_sample_3m
GROUP BY AIRLINE
ORDER BY avg_air_time DESC;

SELECT
    ORIGIN,
    COUNT(*) AS total_flights,
    ROUND(AVG(DEP_DELAY), 2) AS avg_departure_delay
FROM flight.flights_sample_3m
GROUP BY ORIGIN
HAVING COUNT(*) >= 1000
ORDER BY avg_departure_delay DESC
LIMIT 20;

SELECT
    COUNT(*) AS total_flights,
    COUNT(DISTINCT AIRLINE) AS total_airlines,
    COUNT(DISTINCT ORIGIN) AS origin_airports,
    COUNT(DISTINCT DEST) AS destination_airports,
    ROUND(AVG(DEP_DELAY), 2) AS avg_departure_delay,
    ROUND(AVG(ARR_DELAY), 2) AS avg_arrival_delay,
    ROUND(AVG(DISTANCE), 2) AS avg_distance,
    SUM(CASE WHEN CANCELLED = 1 THEN 1 ELSE 0 END) AS cancelled_flights,
    SUM(CASE WHEN DIVERTED = 1 THEN 1 ELSE 0 END) AS diverted_flights
FROM flight.flights_sample_3m;























