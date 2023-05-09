import 'package:cryptox/logics/cubit/ohlcv_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../datas/data-providers/logo_api.dart';
import '../../logics/bloc/current_price_bloc.dart';
import '../../logics/cubit/asset_cubit.dart';
import '../loading_spinner.dart';
import 'crypto_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.center,
                colors: [
                  Color(0xFF565F49),
                  Color(0xFF29262A),
                ],
              ),
            ),
            child: SingleChildScrollView(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: const CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage("assets/images/p1.jpg"),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      margin: const EdgeInsets.only(top: 10),
                      child: const Text(
                        "\$12,345.03",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 40),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      margin: const EdgeInsets.only(top: 20),
                      child: Container(
                        width: 200,
                        decoration: BoxDecoration(
                          color: const Color(0xffc8f89b),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Flexible(
                              child: Text(
                                "+5.25%",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Container(
                              height: 24,
                              width: 1,
                              color: Colors.black,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 16),
                            ),
                            const Flexible(
                              child: Text(
                                "\$+642.26",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    _Buttons(),
                    _Crytpos(),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

class _Buttons extends StatelessWidget {
  Widget button({required String imageName, required String textName}) =>
      Container(
          margin: const EdgeInsets.only(right: 20),
          child: Column(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: InkWell(
                  child:
                      Ink(child: Image.asset("assets/images/$imageName.png")),
                  onTap: () => print("tapping $textName"),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(5),
                child: Text(
                  textName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              )
            ],
          ));

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 20,
        left: 10,
      ),
      child: SizedBox(
        height: 100,
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: [
            button(imageName: "down-left-arrow", textName: "Receive"),
            button(imageName: "up-right-arrow", textName: "Send"),
            button(imageName: "swap", textName: "Swap"),
            button(imageName: "tag", textName: "Buy"),
            button(imageName: "tag", textName: "Sell"),
            button(imageName: "tag", textName: "Buy"),
          ],
        ),
      ),
    );
  }
}

class _Crytpos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: const Text(
              "Cryptos",
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child:
                BlocBuilder<AssetCubit, AssetState>(builder: (context, state) {
              if (state is AssetInitial) {
                return loadingSpinner();
              } else if (state is AssetError) {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                );
              } else if (state is AssetLoaded) {
                final assets = state.assets;
                final assetCubit = context.read<AssetCubit>();

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var nameSymbol = Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            assets[index]!.name!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            assets[index]!.symbol!.toUpperCase(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Color(0xff7a7a81), fontSize: 14),
                          )
                        ],
                      ),
                    );
                    var pricePercent = Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            assetCubit.roundPrice(assets[index]!.priceUsd!),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                          const SizedBox(height: 5),
                          RichText(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                  style: TextStyle(
                                      color: assetCubit
                                              .checkPercentPositiveNegative(
                                                  assets[index]!
                                                      .changePercent24Hr!)
                                          ? Colors.red
                                          : Colors.green,
                                      fontSize: 14),
                                  children: [
                                    TextSpan(
                                      text: assetCubit.roundChangePercent(
                                          assets[index]!.changePercent24Hr!),
                                    ),
                                    WidgetSpan(
                                        child: assetCubit
                                                .checkPercentPositiveNegative(
                                                    assets[index]!
                                                        .changePercent24Hr!)
                                            ? const Icon(
                                                Icons.arrow_downward_rounded,
                                                size: 16,
                                                color: Colors.red,
                                              )
                                            : const Icon(
                                                Icons.arrow_upward_rounded,
                                                size: 16,
                                                color: Colors.green,
                                              ))
                                  ])),
                        ],
                      ),
                    );
                    var coinImg = Container(
                      alignment: Alignment.topCenter,
                      margin:
                          const EdgeInsets.only(top: 5, bottom: 5, right: 5),
                      width: 40,
                      child: Image.network(
                        LogoApi.assetLogo(assets[index]!.symbol!.toLowerCase()),
                        width: 40,
                        alignment: Alignment.topCenter,
                        fit: BoxFit.contain,
                        errorBuilder: (context, _, __) => const CircleAvatar(
                          backgroundColor: Colors.red,
                        ),
                      ),
                    );
                    return Container(
                      margin: const EdgeInsets.only(top: 10),
                      height: 100,
                      child: GestureDetector(
                        child: Card(
                          color: const Color(0xff3e3e47),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Container(
                            margin: const EdgeInsets.only(
                                top: 10, left: 5, right: 5, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                coinImg,
                                nameSymbol,
                                pricePercent,
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          context.read<CurrentPriceBloc>().add(
                              StartCurrentPriceEvent(assets[index]!.name!));

                          context
                              .read<OHLCVCubit>()
                              .oHLCV(assets[index]!.symbol!);
                          Navigator.pushNamed(context, CryptoScreen.routeName);
                        },
                      ),
                    );
                  },
                  itemCount: assets.length,
                );
              }
              return Container();
            }),
          ),
        ],
      ),
    );
  }
}
