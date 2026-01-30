# Weather Analytics SQL Project

## Project Overview
This project demonstrates end-to-end SQL analytics using real-world daily weather data from Meteostat.  
The goal is to design a clean relational database, ingest raw data, perform transformations, and generate analytical insights using SQL.

The project follows a **staging → dimension → fact** pipeline and includes reusable views, data quality checks, indexing, and analytical queries.

---

## Project Structure

sql-weather-analytics/
├── data/
│   └── raw/
│       └── meteostat_KM210_daily.csv
│
├── schema/
│   ├── 00_create_staging.sql
│   ├── 01_create_tables.sql
│   └── 02_constraints_indexes.sql
│
├── sql/
│   ├── 00_data_quality_checks.sql
│   ├── 01_transformations.sql
│   ├── 02_analysis.sql
│   └── 03_views.sql
│
├── outputs/
│
├── weather.db
└── README.md

---

## Database Design
The database follows a **star schema** optimized for analytical workloads.

### Tables

- **stg_daily_weather_raw**  
  Raw staging table used to ingest daily CSV weather data with minimal transformation.

- **dim_station**  
  Dimension table containing weather station metadata.

- **dim_date**  
  Calendar dimension table with derived fields such as year, month, weekday, and season.

- **fact_daily_weather**  
  Fact table containing daily temperature and precipitation measurements.

### Views

- **vw_daily_weather_summary**  
  A reusable reporting view joining the fact table with date and station dimensions to simplify analysis.

---

## Data Pipeline

1. Raw CSV weather data is imported into a staging table.
2. Data quality checks validate row counts, duplicates, and missing values.
3. Dimension tables (`dim_station`, `dim_date`) are populated from staging data.
4. Cleaned and structured data is loaded into the fact table (`fact_daily_weather`).
5. Primary keys, foreign keys, and indexes are created to optimize query performance.
6. Analytical queries and views are executed against the fact table.

---

## Example Analytics
This project includes analytical queries such as:
- Daily temperature range calculations
- Total precipitation over a selected time period
- 7-day rolling average temperatures using window functions
- Calendar- and season-based aggregations
- Reusable reporting views for downstream analysis

### Example Query: 7-Day Rolling Average Temperature

```sql
SELECT
  date_id,
  tavg_c,
  AVG(tavg_c) OVER (
    ORDER BY date_id
    ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
  ) AS rolling_7d_avg_c
FROM fact_daily_weather;