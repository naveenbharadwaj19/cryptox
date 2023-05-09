import 'package:http/http.dart' as http;

import 'base_url.dart';

class AssetsApi with CoinCapBase {
  Future<http.Response> getAssets({int limit = 30}) async {
    var res = await http.get(Uri.parse("$baseUrl/assets?limit=$limit"),
        headers: headers());
    return res;
  }
}
