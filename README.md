# Portfolio Analysis & Performance Dashboard

A comprehensive data analytics project for analyzing and visualizing multi-asset portfolio performance, combining South African equities with US technology stocks, including currency conversion and performance metrics.

## 📋 Project Overview

This project orchestrates a complete data pipeline for portfolio analysis, tracking and comparing the performance of:
- **South African Equities**: FirstRand, Standard Bank, Naspers, Anglo American, MTN Group
- **US Technology Stocks**: Apple, Microsoft, Nvidia
- **Currency Data**: USD/ZAR exchange rates

The project combines data processing, SQL analytics, and interactive visualizations to provide insights into portfolio performance over time.

## 📁 Project Structure

```
DMA project/
├── data_processing.ipynb          # Main data pipeline & ETL notebook
├── Sql_quiries.sql                # SQL views and data transformations
├── peformance visualisation.twb   # Tableau workbook for performance visualizations
├── Perfomance Dashboard.twb       # Tableau dashboard for performance metrics
├── README.md                       # This file
├── data/                           # Raw and processed datasets
│   ├── wide_market_data.csv       # Wide format market data
│   ├── long_market_data.csv       # Long format market data
│   └── filtered_wide_market_data.csv # Cleaned wide format data
└── view/                           # Analytics views and outputs
    ├── daily_performace.csv       # Daily performance metrics by asset
    ├── growth_comparison.csv      # Rebased growth comparison across assets
    └── portfolio.csv              # Portfolio summary data
```

## 🔧 Components

### 1. Data Processing (`data_processing.ipynb`)
A Python-based Jupyter notebook that handles:
- **Data Retrieval**: Downloads 2 years of historical daily price data from Yahoo Finance
- **Data Cleaning**: Handles missing values, validates data quality, standardizes naming conventions
- **Data Transformation**: Converts between wide/long formats, creates structured views
- **Output Generation**: Exports processed datasets to CSV format

**Key Libraries**: `yfinance`, `pandas`, `datetime`

### 2. SQL Analytics (`Sql_quiries.sql`)
Database queries and views that:
- **Data Type Conversion**: Converts date fields from text to proper date format
- **vw_portfolio_master**: Creates a master view with currency-adjusted prices (USD assets converted to ZAR)
- **vw_daily_performance**: Calculates daily return percentages for each asset
- **vw_growth_comparison**: Rebases growth metrics using initial prices as baseline (100)

### 3. Tableau Visualizations
Two Tableau workbooks for interactive dashboards:
- **peformance visualisation.twb**: Detailed performance analysis and trend visualizations
- **Perfomance Dashboard.twb**: Executive summary dashboard with key metrics

### 4. Data Files

**Raw Data** (`/data`):
- `wide_market_data.csv`: Asset prices in wide format (one row per date, multiple columns per asset)
- `long_market_data.csv`: Asset prices in long format (one row per asset-date combination)
- `filtered_wide_market_data.csv`: Cleaned and validated wide format data

**Processed Views** (`/view`):
- `daily_performace.csv`: Daily return percentages for each asset
- `growth_comparison.csv`: Rebased growth comparison (indexed to 100 at start date)
- `portfolio.csv`: Portfolio-level summary metrics

## 🚀 Quick Start

### Prerequisites
- Python 3.7+
- Jupyter Notebook
- Required Python packages: `yfinance`, `pandas`
- MySQL/MariaDB (for SQL analytics)
- Tableau Public or Desktop (for visualizations)

### Installation

1. **Python Dependencies**
   ```bash
   pip install yfinance pandas jupyter
   ```

2. **Run Data Pipeline**
   - Open `data_processing.ipynb` in Jupyter Notebook
   - Execute cells sequentially to download and process market data
   - CSV files will be generated in `/data` and `/view` directories

3. **Database Setup** (Optional)
   - Create a MySQL database called `market_data`
   - Execute SQL queries from `Sql_quiries.sql` to create views and transform data
   - Views will be available for Tableau connections

4. **View Visualizations**
   - Open `.twb` files in Tableau to explore interactive dashboards

## 📊 Key Features

✅ **Multi-Asset Portfolio Analysis** - Track performance across diverse assets  
✅ **Currency Conversion** - Automatic USD to ZAR conversion for international assets  
✅ **Daily Performance Metrics** - Track daily returns and volatility  
✅ **Growth Comparison** - Rebased growth metrics for easy comparison  
✅ **Interactive Dashboards** - Tableau-based visualizations for insights  
✅ **Automated Data Pipeline** - Scheduled data downloads and updates via Python  

## 📈 Analytical Views

### Daily Performance
Calculates daily percentage returns using:
```
Daily Return % = ((Current Price - Previous Day Price) / Previous Day Price) × 100
```

### Growth Comparison
Rebases all assets to 100 at the start date:
```
Rebased Price = (Current Price / Initial Price) × 100
```

### Currency Adjustment
US technology stocks are converted from USD to ZAR using daily exchange rates from the data.

## 🔄 Data Flow

```
Yahoo Finance Data
        ↓
[data_processing.ipynb] → Data Cleaning & Transformation
        ↓
CSV Exports (data/ & view/)
        ↓
[Sql_quiries.sql] → Database Views (optional)
        ↓
[Tableau Dashboards] → Interactive Visualizations
```

## 📝 Notes

- All dates are in YYYY-MM-DD format
- Prices are in ZAR (South African Rand) after currency conversion
- Missing data is handled through interpolation
- Analysis covers a 2-year historical period

## 🔐 Data Privacy

This project uses publicly available market data from Yahoo Finance. No sensitive financial information is stored.


## 📄 License

This project is for analytical and educational purposes.

---

**Last Updated**: March 2026
