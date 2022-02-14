-- Homework - Week 3

-- Load Data

CREATE OR REPLACE EXTERNAL TABLE `chu-de-zoomcamp-339115.chu_nytaxi.fhv_tripdata`
OPTIONS (
    format= 'parquet',
    uris= [
        'gs://dtc_data_lake_chu-de-zoomcamp-339115/raw/fhv_tripdata_2019-*',
        'gs://dtc_data_lake_chu-de-zoomcamp-339115/raw/fhv_tripdata_2020-*'
    ]
)


-- 1. What is count for fhv vehicles data for year 2019 a: 42084899

SELECT  COUNT(*) FROM `chu-de-zoomcamp-339115.chu_nytaxi.fhv_tripdata` where  EXTRACT(YEAR FROM pickup_datetime)=2019;


-- 2. How many distinct dispatching_base_num we have in fhv for 2019

SELECT  COUNT(DISTINCT (dispatching_base_num)) FROM `chu-de-zoomcamp-339115.chu_nytaxi.fhv_tripdata` where  EXTRACT(YEAR FROM pickup_datetime)=2019;

-- 3. Best strategy to optimise if query always filter by dropoff_datetime and order by dispatching_base_num

CREATE OR REPLACE TABLE
  `chu-de-zoomcamp-339115.chu_nytaxi.fhv_tripdata_q3`
PARTITION BY
  DATE(dropoff_datetime)
CLUSTER BY
  dispatching_base_num AS
SELECT
  *
FROM
  `chu-de-zoomcamp-339115.chu_nytaxi.fhv_tripdata`;

-- 4. What is the count, estimated and actual data processed for query which counts trip between 2019/01/01 and 2019/03/31 
--    for dispatching_base_num B00987, B02060, B02279

SELECT  COUNT(*) FROM `chu-de-zoomcamp-339115.chu_nytaxi.fhv_tripdata_q3` 
WHERE DATE(pickup_datetime) BETWEEN '2019-01-01' AND '2019-03-31'
AND dispatching_base_num IN ('B00987', 'B02060', 'B02279');

