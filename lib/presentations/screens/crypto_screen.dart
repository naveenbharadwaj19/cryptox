import 'package:cryptox/datas/models/ohlcv_model.dart';
import 'package:cryptox/logics/cubit/ohlcv_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../logics/bloc/current_price_bloc.dart';
import '../loading_spinner.dart';

Future<bool> _onWillPop(BuildContext context) async {
  context.read<CurrentPriceBloc>().add(StopCurrentPriceEvent());
  Navigator.pop(context);
  return false;
}

class CryptoScreen extends StatelessWidget {
  static const routeName = "/crypto-screen";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () => _onWillPop(context),
        child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(context.read<CurrentPriceBloc>().assetName ?? ""),
            elevation: 0,
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [_CurrentPrice(), _CandleStickChart(), _TradeInfo()],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CurrentPrice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentPriceBloc, CurrentPriceState>(
        builder: (context, state) {
      if (state is CurrentPriceInitial || state is CurrentPriceLoading) {
        return Container(
          margin: const EdgeInsets.only(top: 10),
          child: const Text(
            "Loading...",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        );
      } else if (state is CurrentPriceError) {
        return Text(
          state.message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        );
      } else if (state is CurrentPriceLoaded) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Current Price",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "\$${state.price}",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ],
        );
      }

      return Container();
    });
  }
}

class _CandleStickChart extends StatefulWidget {
  @override
  _CandleStickChartState createState() => _CandleStickChartState();
}

class _CandleStickChartState extends State<_CandleStickChart> {
  late TrackballBehavior _trackballBehavior;

  @override
  void initState() {
    _trackballBehavior = TrackballBehavior(
        enable: true, activationMode: ActivationMode.singleTap);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: BlocBuilder<OHLCVCubit, OHLCVState>(
        builder: (context, state) {
          if (state is OHLCVLoading) {
            return loadingSpinner();
          } else if (state is OHLCVError) {
            return Text(
              state.message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            );
          } else if (state is OHLCVLoaded) {
            return SizedBox(
              height: 400,
              child: SfCartesianChart(
                legend: Legend(isVisible: true),
                trackballBehavior: _trackballBehavior,
                series: <CandleSeries>[
                  CandleSeries<OHLCVModel, DateTime>(
                      dataSource: state.ohlcvLst,
                      name: "",
                      xValueMapper: (sales, _) =>
                          DateTime.parse(sales.timePeriodStart),
                      lowValueMapper: (sales, _) => sales.priceLow,
                      highValueMapper: (sales, _) => sales.priceHigh,
                      openValueMapper: (sales, _) => sales.priceOpen,
                      closeValueMapper: (sales, _) => sales.priceClose)
                ],
                primaryXAxis: DateTimeAxis(
                  dateFormat: DateFormat.H(),
                  intervalType: DateTimeIntervalType.hours,
                ),
                primaryYAxis: NumericAxis(),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}

class _TradeInfo extends StatelessWidget {
  Widget info(
          {required String title,
          required String content,
          bool isDivider = true}) =>
      Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 18, color: Color(0xff8b8a8f)),
              ),
              Flexible(
                child: Text(
                  content,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
          !isDivider
              ? Container()
              : const Divider(
                  color: Color(0xff8b8a8f),
                  thickness: 2,
                ),
          const SizedBox(height: 10),
        ],
      );
  @override
  Widget build(BuildContext context) {
    var buttons = Container(
      margin: const EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: SizedBox(
              height: 60,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'Sell',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF48964),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: SizedBox(
              height: 60,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'Buy',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffcbf89b),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    return BlocBuilder<OHLCVCubit, OHLCVState>(
      builder: (context, state) {
        if (state is OHLCVLoaded) {
          return Container(
            margin: const EdgeInsets.only(top: 20, left: 5, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                info(
                    title: "Opening Price",
                    content: "\$ ${state.ohlcvLst.first.priceOpen}"),
                info(
                    title: "Closing Price",
                    content: "\$ ${state.ohlcvLst.first.priceClose}"),
                info(
                    title: "Trades Count",
                    content: "\$ ${state.ohlcvLst.first.tradesCount}"),
                info(
                    title: "Volume",
                    content: "\$ ${state.ohlcvLst.first.volumeTraded}",
                    isDivider: false),
                buttons,
                const SizedBox(height: 10),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
