import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restaurant_app/core/error/failure.dart';
import 'package:restaurant_app/features/Authentication/data/models/user_model.dart';

abstract class AuthDataSrc {
  Future<UserModel> signUpWithEmailnPassword(String email, String password,
      String name, String phone, String address, String gender, String dateOfBirth);

  Future<UserModel> signUpWithGoogle(
      {String? name, String? phone, String? address, String? gender, String? dateOfBirth});

  Future<UserModel> signUpWithFacebook(
      {String? name, String? phone, String? address, String? gender, String? dateOfBirth});

  Future<UserModel> signInWithEmailnPassword(String email, String password);

  Future<bool> forgetPassword(String email);

  Future<bool> signOut();

  Future<UserModel> getUser();

  Future<UserModel> setUser(
    bool isFirst,
    String email,
    String phone,
    String address,
    String gender,
    String fullName,
    String dateOfBirth);
}
