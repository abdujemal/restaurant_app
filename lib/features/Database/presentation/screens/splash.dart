import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/features/Authentication/presentation/bloc/login_controller/login_state.dart';
import 'package:restaurant_app/features/Database/presentation/screens/main_screen.dart';
import 'package:restaurant_app/features/Database/presentation/screens/walkthrough.dart';
import 'package:restaurant_app/core/util/const.dart';

import '../../../Authentication/presentation/bloc/login_controller/login_bloc.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        Timer(const Duration(seconds: 2), () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) {
              return state.currentUser != null ? MainScreen() : Walkthrough();
            }),
          );
        });
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Container(
          margin: const EdgeInsets.only(left: 40.0, right: 40.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(
                  Icons.fastfood,
                  size: 150.0,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                const SizedBox(width: 40.0),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(
                    top: 15.0,
                  ),
                  child: Text(
                    "${Constants.appName}",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
                const SizedBox(height: 40,),
                const Center(child: CircularProgressIndicator(color: Colors.red,))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
