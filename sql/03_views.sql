DROP VIEW IF EXISTS vw_daily_weather_summary;

CREATE VIEW vw_daily_weather_summary AS
SELECT
  date_id      AS date,
  tavg_c       AS tavg,
  tmin_c       AS tmin,
  tmax_c       AS tmax,
  prcp_mm      AS precipitation_mm,
  snow_mm      AS snow_mm
FROM fact_daily_weather;