part of 'current_price_bloc.dart';

abstract class CurrentPriceState extends Equatable {
  const CurrentPriceState();

  @override
  List<Object> get props => [];
}

class CurrentPriceInitial extends CurrentPriceState {}

class CurrentPriceLoaded extends CurrentPriceState {
  String price;

  CurrentPriceLoaded(this.price);

  @override
  List<Object> get props => [price];
}

class CurrentPriceLoading extends CurrentPriceState {}

class CurrentPriceError extends CurrentPriceState {
  String message;
  CurrentPriceError(this.message);

  @override
  List<Object> get props => [message];
}

