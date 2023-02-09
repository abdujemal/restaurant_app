import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/core/useCase/base_usecase.dart';
import 'package:restaurant_app/core/util/const.dart';
import 'package:restaurant_app/features/Authentication/domain/usecases/forget_password_usecase.dart';
import 'package:restaurant_app/features/Authentication/domain/usecases/get_user_usecase.dart';
import 'package:restaurant_app/features/Authentication/domain/usecases/set_user_usecase.dart';
import 'package:restaurant_app/features/Authentication/domain/usecases/sign_in_with_email_n_password.dart';
import 'package:restaurant_app/features/Authentication/domain/usecases/sign_out_usecase.dart';
import 'package:restaurant_app/features/Authentication/domain/usecases/sign_up_with_facebook_usecase.dart';
import 'package:restaurant_app/features/Authentication/domain/usecases/sign_up_with_google_usecase.dart';
import 'package:restaurant_app/features/Authentication/domain/usecases/signup_with_email_n_password_usecase.dart';
import 'package:restaurant_app/features/Authentication/presentation/bloc/login_controller/login_event.dart';
import 'package:restaurant_app/features/Authentication/presentation/bloc/login_controller/login_state.dart';
import 'package:restaurant_app/features/Database/presentation/controller/food%20controlelr/food_bloc.dart';

import '../../../../../injection.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  SignInWithEmailnPasswordUsecase signInWithEmailnPasswordUsecase;
  SignUpWithEmailnPasswordUsecase signUpWithEmailnPasswordUsecase;
  SignUpWithFacebookUsecase signUpWithFacebookUsecase;
  SignUpWithGoogleUsecase signUpWithGoogleUsecase;
  ForgetPasswordUsecase forgetPasswordUsecase;
  SignOutUsecase signOutUsecase;
  GetUserUsecase getUserUsecase;
  SetUserUseCase setUserUseCase;

  LoginBloc(
      this.getUserUsecase,
      this.forgetPasswordUsecase,
      this.signInWithEmailnPasswordUsecase,
      this.signOutUsecase,
      this.signUpWithEmailnPasswordUsecase,
      this.signUpWithFacebookUsecase,
      this.signUpWithGoogleUsecase,
      this.setUserUseCase)
      : super(LoginState()) {
    on<SignUpWithEmailEvent>(_signUpWithEmail);

    on<SignUpWithGoogleEvent>(_signUpWithGoogle);

    on<SignUpWithFacebookEvent>(_signUpWithFacebook);

    on<SignInWithEmailEvent>(_signInWithEmail);

    on<ForgetPasswordEvent>(_forgetPassword);

    on<SignOutEvent>(_signOut);

    on<GetUserEvent>(_getUser);

    on<SetUserEvent>(_setUser);
  }

  FutureOr<void> _forgetPassword(
      ForgetPasswordEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(forgetPState: RequestState.loading, forgetPError: ''));
    final result = await forgetPasswordUsecase
        .call(ForgetPasswordParameter(email: event.email));

    result.fold(
        (l) => emit(state.copyWith(
            forgetPState: RequestState.error, forgetPError: l.toString())),
        (r) => emit(state.copyWith(forgetPState: RequestState.loaded)));
  }

  FutureOr<void> _signOut(SignOutEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(signOutState: RequestState.loading, signOutError: ''));

    final result = await signOutUsecase.call(const NoParameters());

    result.fold(
        (l) => emit(state.copyWith(
            signOutState: RequestState.error, signOutError: l.toString())),
        (r) => emit(state.copyWith(
            signOutState: RequestState.loaded, currentUser: null)));
  }

  FutureOr<void> _getUser(GetUserEvent event, Emitter<LoginState> emit) async {
    final result = await getUserUsecase.call(const NoParameters());

    result.fold((l) => emit(state.copyWith(currentUser: null)),
        (r) => emit(state.copyWith(currentUser: r)));
  }

  FutureOr<void> _signUpWithFacebook(
      SignUpWithFacebookEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(
        signUpFacebookState: RequestState.loading, signUpFacebookError: ''));

    final result = await signUpWithFacebookUsecase.call(SignUpGoogleParameter(
        address: event.address,
        name: event.name,
        phone: event.phone,
        gender: event.gender,
        dateOfBirth: event.dateOfBirth));

    result.fold(
        (l) => emit(state.copyWith(
            signUpFacebookState: RequestState.error,
            signUpFacebookError: l.toString())),
        (r) => emit(state.copyWith(
            signUpFacebookState: RequestState.loaded, currentUser: r)));
  }

  FutureOr<void> _signInWithEmail(
      SignInWithEmailEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(
        signInEmailState: RequestState.loading, signInEmailError: ''));

    final result = await signInWithEmailnPasswordUsecase
        .call(SignInWithEmailPasswordParameter(event.email, event.password));

    result.fold(
        (l) => emit(state.copyWith(
            signInEmailState: RequestState.error,
            signInEmailError: l.toString())),
        (r) => emit(state.copyWith(
            signInEmailState: RequestState.loaded, currentUser: r)));
  }

  FutureOr<void> _signUpWithGoogle(
      SignUpWithGoogleEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(
        signUpGoogleState: RequestState.loading, signUpGoogleError: ''));

    final result = await signUpWithGoogleUsecase.call(SignUpGoogleParameter(
        address: event.address,
        name: event.name,
        phone: event.phone,
        gender: event.gender,
        dateOfBirth: event.dateOfBirth));

    result.fold(
        (l) => emit(state.copyWith(
            signUpGoogleState: RequestState.error,
            signUpGoogleError: l.toString())),
        (r) => emit(state.copyWith(
            signUpGoogleState: RequestState.loaded, currentUser: r)));
  }

  FutureOr<void> _signUpWithEmail(
      SignUpWithEmailEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(
        signUpEmailState: RequestState.loading, signUpEmailError: ''));

    final result = await signUpWithEmailnPasswordUsecase.call(
        SignUpWEmailPasswordParameters(event.email, event.password, event.name,
            event.phone, event.address, event.gender, event.dateOfBirth));

    result.fold(
        (l) => emit(state.copyWith(
            signUpEmailState: RequestState.error,
            signUpEmailError: l.toString())),
        (r) => emit(state.copyWith(
            signUpEmailState: RequestState.loaded, currentUser: r)));
  }

  FutureOr<void> _setUser(SetUserEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(setUserState: RequestState.loading, setUserError: ""));

    final result = await setUserUseCase.call(SetUserParameter(isFirst: event.isFirst, email: event.email, phone: event.address, address: event.address, gender: event.gender, fullName: event.fullName, dateOfBirth: event.dateOfBirth));

    result.fold(
        (l) => emit(state.copyWith(
            setUserState: RequestState.error, setUserError: l.toString())),
        (r) => emit(
            state.copyWith(setUserState: RequestState.loaded, currentUser: r)));
  }
}
