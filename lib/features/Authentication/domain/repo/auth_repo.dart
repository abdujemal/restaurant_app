import 'package:dartz/dartz.dart';
import 'package:restaurant_app/features/Authentication/data/models/user_model.dart';

abstract class AuthRepo {
  Future<Either<Exception, UserModel>> signUpWithEmailnPassword(
      String email,
      String password,
      String name,
      String phone,
      String address,
      String gender,
      String dateOfBirth);

  Future<Either<Object, UserModel>> signUpWithGoogle(
      {String? name, 
      String? phone, 
      String? address, 
      String? gender,
      String? dateOfBirth});

  Future<Either<Exception, UserModel>> signUpWithFacebook(
      {String? name, String? phone, String? address, String? gender, String? dateOfBirth});

  Future<Either<Exception, UserModel>> signInWithEmailnPassword(
      String email, String password);

  Future<Either<Exception, bool>> forgetPassword(String email);

  Future<Either<Exception, bool>> signOut();

  Future<Either<Exception, UserModel>> getUser();

  Future<Either<Exception, UserModel>> setUser(
    bool isFirst,
    String email,
  String phone,
  String address,
  String gender,
  String fullName,
  String dateOfBirth
  );
}
