-- Enable foreign keys (SQLite-specific)
PRAGMA foreign_keys = ON;

-- Indexes for common query patterns
CREATE INDEX IF NOT EXISTS idx_fact_weather_date
  ON fact_daily_weather(date_id);

CREATE INDEX IF NOT EXISTS idx_fact_weather_station
  ON fact_daily_weather(station_id);

-- Optional: index for faster joins on dim_date
CREATE INDEX IF NOT EXISTS idx_dim_date_date
  ON dim_date(date_id);