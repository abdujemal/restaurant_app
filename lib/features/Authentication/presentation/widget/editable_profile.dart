import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_app/features/Authentication/data/models/user_model.dart';
import 'package:restaurant_app/features/Authentication/presentation/bloc/login_controller/login_bloc.dart';
import 'package:restaurant_app/features/Authentication/presentation/bloc/login_controller/login_event.dart';
import 'package:restaurant_app/features/Authentication/presentation/bloc/login_controller/login_state.dart';
import 'package:restaurant_app/features/Authentication/presentation/widget/auth_input.dart';

import '../../../../core/util/const.dart';

class EditableProfile extends StatefulWidget {
  final UserModel userModel;
  const EditableProfile({super.key, required this.userModel});

  @override
  State<EditableProfile> createState() => _EditableProfileState();
}

class _EditableProfileState extends State<EditableProfile> {
  var _profileForm = GlobalKey<FormState>();

  var _usernameControl = TextEditingController();

  var _dateController = TextEditingController();

  var _genderVal = "Male";

  var _emailControl = TextEditingController();

  var _phoneControl = TextEditingController();

  var _addressControl = TextEditingController();

  @override
  void initState() {
    super.initState();

    _usernameControl.text = widget.userModel.fullName;

    _dateController.text = widget.userModel.dateOfBirth;

    _genderVal =
        widget.userModel.gender.isEmpty ? "Male" : widget.userModel.gender;

    _emailControl.text = widget.userModel.email;

    _phoneControl.text = widget.userModel.phone;

    _addressControl.text = widget.userModel.address;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
            key: _profileForm,
            child: Column(
              children: [
                Container(height: 15.0),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    "Editing Account Information".toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
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
                SizedBox(
                  height: 10,
                ),
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
                BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state.setUserState == RequestState.loaded) {
                      Constants.toast(
                          "Your profile has been successfully updated.",
                          ToastType.success);
                    }

                    if (state.setUserState == RequestState.loaded) {
                      Constants.toast(state.setUserError, ToastType.error);
                    }
                  },
                  builder: (context, state) {
                    return state.setUserState == RequestState.loading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : SizedBox(
                            height: 50.0,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_profileForm.currentState!.validate()) {
                                  context.read<LoginBloc>().add(SetUserEvent(
                                    isFirst: false,
                                      email: _emailControl.text,
                                      phone: _phoneControl.text,
                                      address: _addressControl.text,
                                      gender: _genderVal,
                                      fullName: _usernameControl.text,
                                      dateOfBirth: _dateController.text));
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).accentColor,
                              ),
                              child: Text(
                                "Save Changes".toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                  },
                )
              ],
            )),
      ],
    );
  }
}
