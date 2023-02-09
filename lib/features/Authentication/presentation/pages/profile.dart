import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/features/Authentication/data/models/user_model.dart';
import 'package:restaurant_app/features/Authentication/presentation/bloc/login_controller/login_bloc.dart';
import 'package:restaurant_app/features/Authentication/presentation/bloc/login_controller/login_event.dart';
import 'package:restaurant_app/features/Authentication/presentation/bloc/login_controller/login_state.dart';
import 'package:restaurant_app/features/Authentication/presentation/pages/join.dart';
import 'package:restaurant_app/features/Authentication/presentation/widget/editable_profile.dart';
import 'package:restaurant_app/features/Authentication/presentation/widget/uneditable_profile.dart';
import 'package:restaurant_app/features/Database/presentation/screens/splash.dart';
import 'package:restaurant_app/core/util/const.dart';

import '../../../../core/providers/app_provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isEditing = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.signOutState == RequestState.error) {
              Constants.toast(state.signOutError, ToastType.error);
            }
          },
          builder: (context, state) {
            UserModel userModel = state.currentUser!;
            return ListView(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: userModel.image.isEmpty
                            ? const Icon(
                                Icons.email,
                                size: 40,
                              )
                            : CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage(userModel.image),
                              )),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                userModel.fullName,
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                userModel.email,
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              BlocConsumer<LoginBloc, LoginState>(
                                listener: (context, state) {
                                  if (state.signOutState ==
                                      RequestState.loaded) {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return JoinApp();
                                        },
                                      ),
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  return state.signOutState ==
                                          RequestState.loading
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : InkWell(
                                          onTap: () {
                                            context
                                                .read<LoginBloc>()
                                                .add(SignOutEvent());
                                          },
                                          child: Text(
                                            "Logout",
                                            style: TextStyle(
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w400,
                                              color:
                                                  Theme.of(context).accentColor,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                const Divider(),
                Stack(
                  children: [
                    isEditing
                        ? EditableProfile(
                            userModel: userModel,
                          )
                        : UnEditableProfile(userModel: userModel),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: isEditing
                            ? const Icon(
                                Icons.check,
                                color: Colors.green,
                              )
                            : const Icon(Icons.edit),
                        onPressed: () {
                          setState(() {
                            isEditing = !isEditing;
                          });
                        },
                      ),
                    )
                  ],
                ),
                MediaQuery.of(context).platformBrightness == Brightness.dark
                    ? const SizedBox()
                    : ListTile(
                        title: const Text(
                          "Dark Theme",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        trailing: Switch(
                          value: Provider.of<AppProvider>(context).theme ==
                                  Constants.lightTheme
                              ? false
                              : true,
                          onChanged: (v) async {
                            if (v) {
                              Provider.of<AppProvider>(context, listen: false)
                                  .setTheme(Constants.darkTheme, "dark");
                            } else {
                              Provider.of<AppProvider>(context, listen: false)
                                  .setTheme(Constants.lightTheme, "light");
                            }
                          },
                          activeColor: Theme.of(context).accentColor,
                        ),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
