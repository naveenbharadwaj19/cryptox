import 'package:flutter_dotenv/flutter_dotenv.dart';

mixin CoinCapBase {
  String baseUrl = "https://api.coincap.io/v2";
  String apiKey = dotenv.env["API_KEY"] as String;
  Map<String, String> headers() => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $apiKey',
      };
}

mixin CoinApiBase {
  String baseUrl = "https://rest.coinapi.io/v1";
  String apiKey = dotenv.env["X-CoinAPI-Key"] as String;
  Map<String, String> headers() => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-CoinAPI-Key': apiKey,
      };
}
