import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:restaurant_app/core/util/const.dart';
import 'package:restaurant_app/features/Authentication/presentation/bloc/login_controller/login_bloc.dart';
import 'package:restaurant_app/features/Authentication/presentation/bloc/login_controller/login_event.dart';
import 'package:restaurant_app/features/Authentication/presentation/bloc/login_controller/login_state.dart';
import 'package:restaurant_app/features/Authentication/presentation/widget/auth_input.dart';
import 'package:restaurant_app/features/Database/presentation/screens/main_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailControl = new TextEditingController();
  final TextEditingController _passwordControl = new TextEditingController();

  var _loginFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailControl.dispose();
    _passwordControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          const SizedBox(height: 10.0),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(
              top: 25.0,
            ),
            child: Text(
              "Log in to your account",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          const SizedBox(height: 30.0),
          Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _loginFormKey,
              child: Column(
                children: [
                  AuthInput(
                      isObsqure: false,
                      controller: _emailControl,
                      prefixIconData: Icons.email,
                      hint: "Email"),
                  const SizedBox(height: 10.0),
                  AuthInput(
                      isObsqure: true,
                      controller: _passwordControl,
                      prefixIconData: Icons.lock,
                      hint: "Password")
                ],
              )),
          const SizedBox(height: 10.0),
          BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state.forgetPState == RequestState.error) {
                Constants.toast(state.forgetPError, ToastType.error);
              }
            },
            builder: (context, state) {
              if (state.forgetPState == RequestState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    onPressed: () {
                      if (_emailControl.text.isNotEmpty) {
                      } else {
                        Constants.toast(
                            "Please provide your email.", ToastType.error);
                      }
                    },
                  ),
                );
              }
            },
          ),
          const SizedBox(height: 30.0),
          BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state.signInEmailState == RequestState.error) {
                Constants.toast(state.signInEmailError, ToastType.error);
              } else if (state.signInEmailState == RequestState.loaded) {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => MainScreen()));
              }
            },
            builder: (context, state) {
              if (state.signInEmailState == RequestState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return SizedBox(
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_loginFormKey.currentState!.validate()) {
                        context.read<LoginBloc>().add(SignInWithEmailEvent(
                            _emailControl.text, _passwordControl.text));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                    child: Text(
                      "LOGIN".toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              }
            },
          ),
          const SizedBox(height: 10.0),
          Divider(
            color: Theme.of(context).colorScheme.secondary,
          ),
          const SizedBox(height: 10.0),
          BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state.signUpGoogleState == RequestState.error) {
                Constants.toast(state.signUpGoogleError, ToastType.error);
              }

              if (state.signUpGoogleState == RequestState.loaded) {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => MainScreen()));
              }

              if (state.signUpFacebookState == RequestState.error) {
                Constants.toast(state.signUpFacebookError, ToastType.error);
              }

              if (state.signUpFacebookState == RequestState.loaded) {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => MainScreen()));
              }
            },
            builder: (context, state) {
              if (state.signUpGoogleState == RequestState.loading ||
                  state.signUpFacebookState == RequestState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Row(
                      children: <Widget>[
                        RawMaterialButton(
                          onPressed: () {
                            context.read<LoginBloc>().add(
                                SignUpWithFacebookEvent(
                                    null, null, null, null, null));
                          },
                          fillColor: Colors.blue[800],
                          shape: const CircleBorder(),
                          elevation: 4.0,
                          child: const Padding(
                            padding: EdgeInsets.all(15),
                            child: Icon(
                              FontAwesomeIcons.facebookF,
                              color: Colors.white,
                              //              size: 24.0,
                            ),
                          ),
                        ),
                        RawMaterialButton(
                          onPressed: () {
                            context.read<LoginBloc>().add(
                                SignUpWithGoogleEvent(
                                    null, null, null, null, null));
                          },
                          fillColor: Colors.white,
                          shape: const CircleBorder(),
                          elevation: 4.0,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Icon(
                              FontAwesomeIcons.google,
                              color: Colors.blue[800],
                              //              size: 24.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
