import 'package:cryptox/logics/cubit/ohlcv_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'logics/bloc/current_price_bloc.dart';
import 'logics/cubit/asset_cubit.dart';
import 'presentations/screens/crypto_screen.dart';
import 'presentations/screens/home_screen.dart';

void main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AssetCubit()),
        BlocProvider(create: (context) => CurrentPriceBloc()),
        BlocProvider(create: (context) => OHLCVCubit())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Crypto',
        theme: ThemeData(primaryColor: const Color(0xff29262a)),
        routes: {
          CryptoScreen.routeName: (context) => CryptoScreen(),
        },
        home: HomeScreen(),
      ),
    );
  }
}
