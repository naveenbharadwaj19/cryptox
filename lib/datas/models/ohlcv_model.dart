import 'package:json_annotation/json_annotation.dart';

part 'ohlcv_model.g.dart';

@JsonSerializable()
class OHLCVModel {
  @JsonKey(name: 'time_period_start')
  String timePeriodStart;

  @JsonKey(name: 'time_period_end')
  String timePeriodEnd;

  @JsonKey(name: 'time_open')
  String timeOpen;

  @JsonKey(name: 'time_close')
  String timeClose;

  @JsonKey(name: 'price_open')
  double priceOpen;

  @JsonKey(name: 'price_high')
  double priceHigh;

  @JsonKey(name: 'price_low')
  double priceLow;

  @JsonKey(name: 'price_close')
  double priceClose;

  @JsonKey(name: 'volume_traded')
  double volumeTraded;

  @JsonKey(name: 'trades_count')
  int tradesCount;

  OHLCVModel({
    required this.timePeriodStart,
    required this.timePeriodEnd,
    required this.timeOpen,
    required this.timeClose,
    required this.priceOpen,
    required this.priceHigh,
    required this.priceLow,
    required this.priceClose,
    required this.volumeTraded,
    required this.tradesCount,
  });

  factory OHLCVModel.fromJson(Map<String, dynamic> json) =>
      _$OHLCVModelFromJson(json);

  Map<String, dynamic> toJson() => _$OHLCVModelToJson(this);
}
