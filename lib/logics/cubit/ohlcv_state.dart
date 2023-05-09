part of 'ohlcv_cubit.dart';

abstract class OHLCVState extends Equatable {
  const OHLCVState();

  @override
  List<Object> get props => [];
}

class OHLCVInitial extends OHLCVState {}

class OHLCVLoading extends OHLCVState {}

class OHLCVLoaded extends OHLCVState {
  List<OHLCVModel> ohlcvLst;
  OHLCVLoaded(this.ohlcvLst);

  @override
  List<Object> get props => [ohlcvLst];
}

class OHLCVError extends OHLCVState {
  String message;

  OHLCVError(this.message);
}
