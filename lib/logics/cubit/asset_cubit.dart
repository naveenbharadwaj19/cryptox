import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../datas/models/asset_model.dart';
import '../../datas/repositories/assets_repository.dart';

part 'asset_state.dart';

class AssetCubit extends Cubit<AssetState> {
  final AssetsRepository _assetsRepository = AssetsRepository();

  AssetCubit() : super(AssetInitial()) {
    _loadAssets();
  }

  Future<void> _loadAssets() async {
    try {
      final assets = await _assetsRepository.getAssets();
      emit(AssetLoaded(assets: assets));
    } catch (error) {
      print(error.toString());
      emit(AssetError("Something went wrong"));
    }
  }

  String roundPrice(String price) {
    double priceDouble = double.parse(price);
    return "\$ ${priceDouble.toStringAsFixed(2)}";
  }

  bool checkPercentPositiveNegative(String changePercent) {
    if (changePercent.startsWith("-")) return true;

    return false;
  }

  String roundChangePercent(String changePercent) {
    double doubleChangePercent = double.parse(changePercent);
    String roundOff = doubleChangePercent.toStringAsFixed(2);
    if(checkPercentPositiveNegative(changePercent)) return "-$roundOff";
    return "+$roundOff";
  }
}
