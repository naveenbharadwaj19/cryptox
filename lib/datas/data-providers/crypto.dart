import 'package:cryptox/datas/data-providers/base_url.dart';
import 'package:http/http.dart' as http;

class Crypto with CoinApiBase {
  Uri currentPrice(String assetName) {
    return Uri.parse("wss://ws.coincap.io/prices?assets=$assetName");
  }

  Future<http.Response> ohlcv(String symbol, {String period = "1DAY"}) async {
    String symbolId = "KRAKEN_SPOT_${symbol}_USD";
    var res = await http.get(
        Uri.parse("$baseUrl/ohlcv/$symbolId/latest?period_id=$period"),
        headers: headers());

    return res;
  }
}
