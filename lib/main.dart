import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/core/providers/app_provider.dart';
import 'package:restaurant_app/features/Authentication/presentation/bloc/login_controller/login_event.dart';
import 'package:restaurant_app/features/Database/presentation/controller/cart_controller/cart_bloc.dart';
import 'package:restaurant_app/features/Database/presentation/controller/food%20controlelr/food_bloc.dart';
import 'package:restaurant_app/features/Database/presentation/screens/splash.dart';
import 'package:restaurant_app/injection.dart';
import 'core/util/const.dart';
import 'features/Authentication/presentation/bloc/login_controller/login_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  di_setup();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (BuildContext context, AppProvider appProvider, Widget? child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => di<LoginBloc>()..add(GetUserEvent())),
            BlocProvider(create: (_)=> di<CartBloc>()),
            BlocProvider(create: (_)=> di<FoodBloc>()..add(GetFoodsEvent()))
            ],

          child: MaterialApp(
            key: appProvider.key,
            debugShowCheckedModeBanner: false,
            navigatorKey: appProvider.navigatorKey,
            title: Constants.appName,
            theme: appProvider.theme.copyWith(
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.transparent,
              //   elevation: 0,
                actionsIconTheme: IconThemeData(color: Colors.grey),
              //   // textTheme: TextTheme(
              //   //     titleLarge: TextStyle(
              //   //     color: Colors.black,
              //   //     fontSize: 18.0,
              //   //     fontWeight: FontWeight.w800,
              //   //   ),
              //   // ),
              //   titleTextStyle: TextStyle(
              //       color: Colors.black,
              //       fontSize: 20,
              //       fontWeight: FontWeight.w600),
              ),
            ),
            darkTheme: Constants.darkTheme,
            home: SplashScreen(),
          ),
        );
      },
    );
  }
}
