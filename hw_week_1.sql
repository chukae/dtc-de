--Question 3: Count records *
--How many taxi trips were there on January 15?
SELECT DATE_TRUNC('DAY', tpep_pickup_datetime) as "Day", COUNT(1) "trips" FROM yellow_taxi_trips 
WHERE EXTRACT(MONTH from tpep_pickup_datetime)=1 AND EXTRACT(DAY from tpep_pickup_datetime)=15
GROUP BY "Day"
ORDER BY "trips" DESC

-- Question 4: Largest tip for each day *
-- On which day it was the largest tip in January? (note: it's not a typo, it's "tip", not "trip")
SELECT tpep_dropoff_datetime, MAX(tip_amount) "tip amount" from yellow_taxi_trips 
WHERE EXTRACT(MONTH from tpep_dropoff_datetime)=1 AND EXTRACT(YEAR from tpep_dropoff_datetime)=2021
GROUP BY tpep_dropoff_datetime
ORDER BY "tip amount" DESC

--Question 5: Most popular destination *
--What was the most popular destination for passengers picked up in central park on January 14? 
--Enter the zone name (not id). If the zone name is unknown (missing), write "Unknown
SELECT
    CONCAT(zpu."Borough", '/', zpu."Zone") AS "pickup_location",
	zdo."Zone",
    --CONCAT(zdo."Borough", '/', zdo."Zone") AS "dropoff_loc",
	COUNT(zdo."Zone") AS "destination_count"
FROM
    yellow_taxi_trips t JOIN zones zpu
        ON t."PULocationID" = zpu."LocationID"
    JOIN zones zdo
        ON t."DOLocationID" = zdo."LocationID"
WHERE DATE_TRUNC('DAY', tpep_pickup_datetime) = '2021-01-14' AND zpu."Zone" = 'Central Park'
GROUP BY "pickup_location",zdo."Zone"
ORDER BY "destination_count" DESC
--Answer 5
--"Manhattan/Central Park"	"Upper East Side South"	97


--Question 6: Most expensive route *
--What's the pickup-dropoff pair with the largest average price for a ride (calculated based on total_amount)? 
--Enter two zone names separated by a slash For example:"Jamaica Bay / Clinton East"If any of the zone names 
-- are unknown (missing), write "Unknown". For example, "Unknown / Clinton East"
SELECT
	CONCAT(COALESCE(zpu."Zone",'Unknown'), '/', COALESCE(zdo."Zone",'Unknown')) AS "pickup_dropoff_pair",
	AVG(total_amount) AS "average_amount"
FROM
    yellow_taxi_trips t JOIN zones zpu
        ON t."PULocationID" = zpu."LocationID"
    JOIN zones zdo
        ON t."DOLocationID" = zdo."LocationID"
GROUP BY "pickup_dropoff_pair"
ORDER BY "average_amount" DESC
LIMIT 1
