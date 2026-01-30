-- Row counts
SELECT (SELECT COUNT(*) FROM dim_station) AS stations,
       (SELECT COUNT(*) FROM dim_date) AS dates,
       (SELECT COUNT(*) FROM fact_daily_weather) AS facts;

-- Check for duplicate fact keys (should return 0 rows)
SELECT station_id, date_id, COUNT(*) AS n
FROM fact_daily_weather
GROUP BY station_id, date_id
HAVING COUNT(*) > 1;

-- Check for missing dates in staging (should be 0)
SELECT SUM(CASE WHEN date IS NULL OR date = '' THEN 1 ELSE 0 END) AS missing_date
FROM stg_daily_weather_raw;