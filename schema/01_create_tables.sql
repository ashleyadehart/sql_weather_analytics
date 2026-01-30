-- Weather Analytics SQL Project (SQLite)
-- Schema: dim_station, dim_date, fact_daily_weather

PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS dim_station (
  station_id TEXT PRIMARY KEY,
  name TEXT,
  country TEXT,
  region TEXT,
  latitude REAL,
  longitude REAL,
  elevation_m REAL
);

CREATE TABLE IF NOT EXISTS dim_date (
  date_id TEXT PRIMARY KEY,          -- ISO format: YYYY-MM-DD
  year INTEGER NOT NULL,
  month INTEGER NOT NULL,
  day INTEGER NOT NULL,
  day_of_week INTEGER NOT NULL,      -- 1=Mon ... 7=Sun
  week_of_year INTEGER NOT NULL,
  season TEXT NOT NULL               -- Winter/Spring/Summer/Fall
);

CREATE TABLE IF NOT EXISTS fact_daily_weather (
  station_id TEXT NOT NULL,
  date_id TEXT NOT NULL,
  tavg_c REAL,
  tmin_c REAL,
  tmax_c REAL,
  prcp_mm REAL,
  snow_mm REAL,
  PRIMARY KEY (station_id, date_id),
  FOREIGN KEY (station_id) REFERENCES dim_station(station_id),
  FOREIGN KEY (date_id) REFERENCES dim_date(date_id)
);