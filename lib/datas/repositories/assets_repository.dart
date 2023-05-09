import 'dart:convert';

import '../data-providers/assets_api.dart';
import '../models/asset_model.dart';

class AssetsRepository {
  final _api = AssetsApi();
  Future<List<AssetModel?>> getAssets() async {
    var res = await _api.getAssets();
    if (res.statusCode == 200) {
      var body = json.decode(res.body);
      List<AssetModel> assets = (body["data"] as List)
          .map((item) => AssetModel.fromJson(item))
          .toList();
      return assets;
    }
    throw Exception("${res.statusCode},${res.body}");
  }
}
