-- Daily temp range
SELECT date_id, (tmax_c - tmin_c) AS daily_temp_range_c
FROM fact_daily_weather
ORDER BY date_id;

-- Total precipitation
SELECT SUM(prcp_mm) AS total_precip_mm
FROM fact_daily_weather;

-- 7-day rolling avg temperature (window function)
SELECT
  date_id,
  tavg_c,
  ROUND(
    AVG(tavg_c) OVER (ORDER BY date_id ROWS BETWEEN 6 PRECEDING AND CURRENT ROW),
    2
  ) AS rolling_7d_avg_c
FROM fact_daily_weather
ORDER BY date_id;