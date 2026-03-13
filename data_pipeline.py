import yfinance as yf
import pandas as pd
from datetime import datetime

# Define the assets and their corresponding clean names
assets = {
    "FSR.JO": "FirstRand",
    "SBK.JO": "Standard_Bank",
    "NPN.JO": "Naspers",
    "AGL.JO": "Anglo_American",
    "MTN.JO": "MTN_Group",
    "AAPL": "Apple",
    "MSFT": "Microsoft",
    "NVDA": "Nvidia",
    "USDZAR=X": "USD_ZAR_Rate"
}

print("Initiating data pull from Yahoo Finance...")

#  Fetching 2 years of daily 'Adjusted Close' prices
raw_data =yf.download(list(assets.keys()), start="2024-01-01")['Close']  


if isinstance(raw_data, pd.Series):
    raw_data = raw_data.to_frame()

# Save Wide Version  
raw_data.to_csv('wide_market_data.csv') 
print(f"Wide Data: {raw_data.shape[1]} columns (Stocks)")

# Import clean_wide_market_data.xlsx and convert to long format
print("\nImporting clean_wide_market_data.xlsx...")
clean_wide_data = pd.read_excel('clean_wide_market_data.xlsx', index_col=0)
clean_wide_data.head()

