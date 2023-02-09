// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:restaurant_app/core/util/const.dart';
import 'package:restaurant_app/features/Authentication/data/models/user_model.dart';

class LoginState extends Equatable {
  RequestState forgetPState;
  String forgetPError;
  UserModel? currentUser;
  RequestState signInEmailState;
  String signInEmailError;
  RequestState signUpEmailState;
  String signUpEmailError;
  RequestState signUpFacebookState;
  String signUpFacebookError;
  RequestState signUpGoogleState;
  String signUpGoogleError;
  RequestState signOutState;
  String signOutError;
  RequestState setUserState;
  String setUserError;


  LoginState(
      {
      this.currentUser,
      this.forgetPError = "",
      this.forgetPState = RequestState.idle,
      this.signInEmailError = "",
      this.signInEmailState = RequestState.idle,
      this.signUpEmailError = "",
      this.signUpEmailState = RequestState.idle,
      this.signUpFacebookError = "",
      this.signUpFacebookState = RequestState.idle,
      this.signOutError = "",
      this.signOutState = RequestState.idle,
      this.signUpGoogleState = RequestState.idle,
      this.signUpGoogleError = "",
      this.setUserState = RequestState.idle,
      this.setUserError = ""
      });

  @override
  List<Object?> get props => [
        forgetPError,
        forgetPState,
        signInEmailError,
        signInEmailState,
        signUpEmailError,
        signUpEmailState,
        signUpFacebookError,
        signUpFacebookState,
        signUpGoogleError,
        signUpGoogleState,
        signInEmailState,
        signOutError,
        signOutState,
        setUserError,
        setUserState
      ];

  LoginState copyWith({
    RequestState? forgetPState,
    String? forgetPError,
    UserModel? currentUser,
    RequestState? signInEmailState,
    String? signInEmailError,
    RequestState? signUpEmailState,
    String? signUpEmailError,
    RequestState? signUpFacebookState,
    String? signUpFacebookError,
    RequestState? signUpGoogleState,
    String? signUpGoogleError,
    RequestState? signOutState,
    String? signOutError,
    RequestState? setUserState,
    String? setUserError,
  }) {
    return LoginState(
      forgetPState: forgetPState ?? this.forgetPState,
      forgetPError: forgetPError ?? this.forgetPError,
      currentUser: currentUser ?? this.currentUser,
      signInEmailState: signInEmailState ?? this.signInEmailState,
      signInEmailError: signInEmailError ?? this.signInEmailError,
      signUpEmailState: signUpEmailState ?? this.signUpEmailState,
      signUpEmailError: signUpEmailError ?? this.signUpEmailError,
      signUpFacebookState: signUpFacebookState ?? this.signUpFacebookState,
      signUpFacebookError: signUpFacebookError ?? this.signUpFacebookError,
      signUpGoogleState: signUpGoogleState ?? this.signUpGoogleState,
      signUpGoogleError: signUpGoogleError ?? this.signUpGoogleError,
      signOutState: signOutState ?? this.signOutState,
      signOutError: signOutError ?? this.signOutError,
      setUserError: setUserError ?? this.setUserError,
      setUserState: setUserState ?? this.setUserState
    );
  }
}
