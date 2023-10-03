import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_app/core/util/const.dart';
import 'package:restaurant_app/features/Authentication/presentation/bloc/login_controller/login_bloc.dart';
import 'package:restaurant_app/features/Authentication/presentation/bloc/login_controller/login_event.dart';
import 'package:restaurant_app/features/Authentication/presentation/bloc/login_controller/login_state.dart';
import 'package:restaurant_app/features/Authentication/presentation/widget/auth_input.dart';
import 'package:restaurant_app/features/Database/presentation/screens/main_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameControl = TextEditingController();
  final TextEditingController _phoneControl = TextEditingController();
  final TextEditingController _addressControl = TextEditingController();
  final TextEditingController _emailControl = TextEditingController();
  final TextEditingController _passwordControl = TextEditingController();

  var _signUpForm = GlobalKey<FormState>();

  var _genderVal = "Male";

  var _dateController = TextEditingController();

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
              "Create an account",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          const SizedBox(height: 30.0),
          Form(
              key: _signUpForm,
              child: Column(
                children: [
                  AuthInput(
                      isObsqure: false,
                      controller: _usernameControl,
                      prefixIconData: Icons.perm_identity,
                      hint: "Username"),
                  const SizedBox(height: 10.0),
                  AuthInput(
                      onTap: () async {
                        DateTime? dateTime = await showDatePicker(
                            context: context,
                            initialDate: DateTime(2000),
                            firstDate: DateTime(1980),
                            lastDate: DateTime(2022));
                        if (dateTime != null) {
                          String date =
                              DateFormat("MMMM dd, yyyy").format(dateTime);
                          setState(() {
                            _dateController.text = date;
                          });
                        }
                      },
                      readOnly: true,
                      isObsqure: false,
                      controller: _dateController,
                      prefixIconData: Icons.date_range_outlined,
                      hint: "Date of Birth"),
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                    elevation: 3.0,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        const Text(
                          "Gender",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(),
                        DropdownButton<String>(
                            value: _genderVal,
                            items: Constants.gender,
                            onChanged: (v) {
                              setState(() {
                                _genderVal = v!;
                              });
                            })
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),
                  AuthInput(
                      isObsqure: false,
                      controller: _emailControl,
                      prefixIconData: Icons.email,
                      hint: "Email"),
                  const SizedBox(height: 10.0),
                  AuthInput(
                      isObsqure: false,
                      controller: _phoneControl,
                      prefixIconData: Icons.phone,
                      hint: "Phone"),
                  const SizedBox(height: 10.0),
                  AuthInput(
                      isObsqure: false,
                      controller: _addressControl,
                      prefixIconData: FontAwesomeIcons.locationPin,
                      hint: "Address"),
                  const SizedBox(height: 10.0),
                  AuthInput(
                      isObsqure: true,
                      controller: _passwordControl,
                      prefixIconData: Icons.lock,
                      hint: "Password"),
                ],
              )),
          const SizedBox(height: 40.0),
          BlocConsumer<LoginBloc, LoginState>(
            builder: (context, state) {
              if (state.signUpEmailState == RequestState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return SizedBox(
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_signUpForm.currentState!.validate()) {
                        context.read<LoginBloc>().add(SignUpWithEmailEvent(
                            _emailControl.text,
                            _passwordControl.text,
                            _usernameControl.text,
                            _phoneControl.text,
                            _addressControl.text,
                            _genderVal,
                            _dateController.text));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                    child: Text(
                      "Register".toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              }
            },
            listener: (context, state) {
              if (state.signUpEmailState == RequestState.error) {
                Constants.toast(state.signUpEmailError, ToastType.error,
                    isLong: true);
              } else if (state.signUpEmailState == RequestState.loaded) {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => MainScreen()));
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
            builder: (context, state) => Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Row(
                  children: <Widget>[
                    state.signUpFacebookState == RequestState.loading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : RawMaterialButton(
                            onPressed: () {
                              if (_signUpForm.currentState!.validate()) {
                                context.read<LoginBloc>().add(
                                    SignUpWithFacebookEvent(
                                        _usernameControl.text,
                                        _phoneControl.text,
                                        _addressControl.text,
                                        _genderVal,
                                        _dateController.text));
                              }
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
                    state.signUpGoogleState == RequestState.loading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : RawMaterialButton(
                            onPressed: () {
                              if (_signUpForm.currentState!.validate()) {
                                context.read<LoginBloc>().add(
                                    SignUpWithGoogleEvent(
                                        _usernameControl.text,
                                        _phoneControl.text,
                                        _addressControl.text,
                                        _genderVal,
                                        _dateController.text));
                              }
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
            ),
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
