import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../datas/models/ohlcv_model.dart';
import '../../datas/repositories/crypto_repository.dart';

part 'ohlcv_state.dart';

class OHLCVCubit extends Cubit<OHLCVState> {
  final CryptoRepository _cryptoRepository = CryptoRepository();
  OHLCVCubit() : super(OHLCVInitial());

  void oHLCV(String symbol) async {
    try {
      emit(OHLCVLoading());
      final ohlcvLst = await _cryptoRepository.ohlcv(symbol);
      if (ohlcvLst != null) {
        emit(OHLCVLoaded(ohlcvLst));
      } else {
        print(ohlcvLst);
        emit(OHLCVError("Something went wrong"));
      }
    } catch (e) {
      print(e.toString());
      emit(OHLCVError("Something went wrong"));
    }
  }
}
