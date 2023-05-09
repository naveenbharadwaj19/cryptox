import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../datas/data-providers/crypto.dart';

part 'current_price_state.dart';

abstract class CurrentPriceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class StartCurrentPriceEvent extends CurrentPriceEvent {
  String assetName;
  StartCurrentPriceEvent(this.assetName);
  @override
  List<Object?> get props => [assetName];
}

class StopCurrentPriceEvent extends CurrentPriceEvent {}

class CurrentPriceBloc extends Bloc<CurrentPriceEvent, CurrentPriceState> {
  final Crypto _crypto = Crypto();

  String? assetName;
  WebSocketChannel? _currentPriceChannel;
  CurrentPriceBloc() : super(CurrentPriceInitial()) {
    on<StartCurrentPriceEvent>((event, emit) async {
      assetName = event.assetName;
      await _currentPrice(assetName: event.assetName.toLowerCase(), emit: emit);
    });
    on<StopCurrentPriceEvent>((event, emit) async {
      await _closeCurrentPrice();
      emit(CurrentPriceInitial());
    });
  }

  Future<void> _closeCurrentPrice() async {
    await _currentPriceChannel?.sink.close(status.normalClosure);
  }

  Future<void> _currentPrice(
      {required String assetName,
      required Emitter<CurrentPriceState> emit}) async {
    try {
      _currentPriceChannel =
          WebSocketChannel.connect(_crypto.currentPrice(assetName));

      await emit.forEach(_currentPriceChannel!.stream,
          onData: (data) {
            if (data == null) {
              return CurrentPriceLoading();
            }
            if (data.toString().isEmpty) {
              return CurrentPriceError("No Data");
            }
            data = json.decode(data.toString());
            return CurrentPriceLoaded(data[assetName]);
          },
          onError: (obj, _) => CurrentPriceError("Error"));
    } catch (e) {
      emit(CurrentPriceError("Error"));
      throw Exception(e.toString());
    }
  }
}
