SELECT
  date_id,
  tmax_c - tmin_c AS daily_temp_range_c
FROM fact_daily_weather
ORDER BY date_id;
