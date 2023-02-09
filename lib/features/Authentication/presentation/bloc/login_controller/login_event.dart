// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:restaurant_app/features/Authentication/data/models/user_model.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class SignUpWithEmailEvent extends LoginEvent {
  String email, password, name, phone, address, gender, dateOfBirth;
  SignUpWithEmailEvent(this.email, this.password, this.name, this.phone,
      this.address, this.gender, this.dateOfBirth);

  @override
  List<Object?> get props =>
      [email, password, name, phone, address, gender, dateOfBirth];
}

class SignUpWithGoogleEvent extends LoginEvent {
  String? name, phone, address, gender, dateOfBirth;
  SignUpWithGoogleEvent(
      this.name, this.phone, this.address, this.gender, this.dateOfBirth);

  @override
  List<Object?> get props => [name, phone, address, gender, dateOfBirth];
}

class SignUpWithFacebookEvent extends LoginEvent {
  String? name, phone, address, gender, dateOfBirth;
  SignUpWithFacebookEvent(
      this.name, this.phone, this.address, this.gender, this.dateOfBirth);

  @override
  List<Object?> get props => [name, phone, address, gender, dateOfBirth];
}

class SignInWithEmailEvent extends LoginEvent {
  String email, password;

  SignInWithEmailEvent(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class ForgetPasswordEvent extends LoginEvent {
  String email;
  ForgetPasswordEvent(this.email);
  @override
  List<Object?> get props => [email];
}

class SignOutEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}

class GetUserEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}

class SetUserEvent extends LoginEvent {
  bool isFirst;
  String email;
  String phone;
  String address;
  String gender;
  String fullName;
  String dateOfBirth;
  SetUserEvent({
    required this.isFirst,
    required this.email,
    required this.phone,
    required this.address,
    required this.gender,
    required this.fullName,
    required this.dateOfBirth,
  });
  @override
  List<Object?> get props =>
      [email, phone, address, gender, fullName, dateOfBirth, isFirst];
}
