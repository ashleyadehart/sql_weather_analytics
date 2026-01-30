-- 1) Station (one-time per station)
INSERT OR IGNORE INTO dim_station (station_id, name)
VALUES ('KM210', 'Meteostat Station KM210');

-- 2) Build dim_date from staging
INSERT OR IGNORE INTO dim_date (
  date_id, year, month, day, day_of_week, week_of_year, season
)
SELECT DISTINCT
  DATE(date) AS date_id,
  CAST(strftime('%Y', date) AS INTEGER),
  CAST(strftime('%m', date) AS INTEGER),
  CAST(strftime('%d', date) AS INTEGER),
  CASE CAST(strftime('%w', date) AS INTEGER)
    WHEN 0 THEN 7 ELSE CAST(strftime('%w', date) AS INTEGER)
  END AS day_of_week,
  CAST(strftime('%W', date) AS INTEGER) AS week_of_year,
  CASE
    WHEN CAST(strftime('%m', date) AS INTEGER) IN (12,1,2) THEN 'Winter'
    WHEN CAST(strftime('%m', date) AS INTEGER) IN (3,4,5) THEN 'Spring'
    WHEN CAST(strftime('%m', date) AS INTEGER) IN (6,7,8) THEN 'Summer'
    ELSE 'Fall'
  END AS season
FROM stg_daily_weather_raw;

-- 3) Load the fact table
INSERT OR REPLACE INTO fact_daily_weather (
  station_id, date_id, tavg_c, tmin_c, tmax_c, prcp_mm, snow_mm
)
SELECT
  'KM210' AS station_id,
  DATE(date) AS date_id,
  tavg AS tavg_c,
  tmin AS tmin_c,
  tmax AS tmax_c,
  COALESCE(prcp, 0) AS prcp_mm,
  COALESCE(snow, 0) AS snow_mm
FROM stg_daily_weather_raw;