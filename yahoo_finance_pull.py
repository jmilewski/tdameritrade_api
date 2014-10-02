import urllib

base_url = "http://ichart.finance.yahoo.com/table.csv?s="
def make_url(ticker_symbol):
    return base_url + ticker_symbol

output_path = "C:/path/to/output/directory"
def make_filename(ticker_symbol, directory="S&P"):
    return output_path + "/" + directory + "/" + ticker_symbol + ".csv"

def pull_historical_data(ticker_symbol, directory="S&P"):
    try:
        urllib.urlretrieve(make_url(ticker_symbol), make_filename(ticker_symbol, directory))
    except urllib.ContentTooShortError as e:
        outfile = open(make_filename(ticker_symbol, directory), "w")
        outfile.write(e.content)
        outfile.close()


# This might be better: pandas comes with historical data downloader for Yahoo: pandas.io.data.DateReader

from pandas.io.data import DataReader
from datetime import datetime
goog = DataReader("GOOG",  "yahoo", datetime(2000,1,1), datetime(2012,1,1))
print goog["Adj Close"]