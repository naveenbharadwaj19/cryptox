import 'dart:convert';

import 'package:cryptox/datas/data-providers/crypto.dart';
import 'package:cryptox/datas/models/ohlcv_model.dart';

class CryptoRepository {
  final Crypto _crypto = Crypto();
  Future<List<OHLCVModel>>? ohlcv(String symbol) async {
    var res = await _crypto.ohlcv(symbol);
    if (res.statusCode == 200) {
      var body = json.decode(res.body);
      List<OHLCVModel> ohlcv =
          (body as List).map((item) => OHLCVModel.fromJson(item)).toList();
      return ohlcv;
    }
    throw Exception("${res.statusCode},${res.body}");
  }
}
