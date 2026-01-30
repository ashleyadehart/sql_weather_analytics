CREATE VIEW IF NOT EXISTS vw_daily_weather_summary AS
SELECT
  f.date_id,
  d.year,
  d.month,
  d.season,
  f.tavg_c,
  f.tmin_c,
  f.tmax_c,
  f.prcp_mm,
  f.snow_mm
FROM fact_daily_weather f
JOIN dim_date d ON f.date_id = d.date_id;