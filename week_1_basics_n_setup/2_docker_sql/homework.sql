SELECT COUNT(*)
FROM yellow_taxi_data
WHERE date(tpep_pickup_datetime) = '2021-01-15';


SELECT date(tpep_pickup_datetime)
FROM yellow_taxi_data
WHERE tip_amount =
      (SELECT MAX(tip_amount) FROM yellow_taxi_data WHERE TO_CHAR(tpep_pickup_datetime, 'YYYY-MM') = '2021-01');


SELECT do_z."Zone", COUNT(*) AS do_count
FROM yellow_taxi_data
         LEFT JOIN zones do_z ON yellow_taxi_data."DOLocationID" = do_z."LocationID"
         LEFT JOIN zones pu_z ON yellow_taxi_data."PULocationID" = pu_z."LocationID"
WHERE pu_z."Zone" = 'Central Park'
  AND date(tpep_pickup_datetime) = '2021-01-14'
GROUP BY do_z."Zone"
ORDER BY do_count DESC
LIMIT 1;

SELECT pu_z."Zone", do_z."Zone", avg(total_amount) AS avg_price
FROM yellow_taxi_data
         LEFT JOIN zones do_z ON yellow_taxi_data."DOLocationID" = do_z."LocationID"
         LEFT JOIN zones pu_z ON yellow_taxi_data."PULocationID" = pu_z."LocationID"

GROUP BY pu_z."Zone", do_z."Zone"
ORDER BY avg_price DESC
LIMIT 1;