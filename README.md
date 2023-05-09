# 💰 CryptoX 💸

CryptoX is a simple cryptocurrency application that allows users to view the latest prices, market cap, and price changes of various cryptocurrencies. This application uses the CoinCap and CoinApi.Io APIs to gather data on cryptocurrencies.

## API's used
The following APIs are used in this application:
- [CoinCap](https://docs.coincap.io/#intro): CoinCap provides real-time cryptocurrency market data, trade data, and order book data from various exchanges.
- [CoinApi.Io](https://www.coinapi.io/): CoinApi.Io provides a unified and consistent API interface for various cryptocurrency exchanges, including historical data.

## Features
The CryptoX application offers the following features:

- View the latest prices of various cryptocurrencies.
- View the market capitalization of cryptocurrencies.
- View the price changes of cryptocurrencies.
- View real-time cryptocurrency prices.
- View candlestick charts for cryptocurrencies.

## Installation
To run CryptoX on your local machine, follow these steps:

1. Clone the repository by running the following command in your terminal: `git clone https://github.com/yourusername/cryptox.git`.
2. Navigate to the cloned repository and install the required packages by running the following command: `flutter pub get`.
3. Create a `.env` file in the root of the project and add your CoinCap and CoinApi.Io API keys as follows:

```
COINCAP_API_KEY=your_coincap_api_key_here
COINAPI_IO_API_KEY=your_coinapi_io_api_key_here
```

4. Start the application by running the following command: `flutter run`.
5. Open your emulator or connect your device and run the app to view the CryptoX application.
