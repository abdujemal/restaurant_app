import 'package:dartz/dartz.dart';
import 'package:restaurant_app/features/Authentication/data/data_source/auth_data_src.dart';
import 'package:restaurant_app/features/Authentication/data/models/user_model.dart';
import 'package:restaurant_app/features/Authentication/domain/repo/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  AuthDataSrc authDataSrc;
  AuthRepoImpl(this.authDataSrc);

  @override
  Future<Either<Exception, bool>> forgetPassword(String email) async {
    try {
      final res = await authDataSrc.forgetPassword(email);
      return Right(res);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, UserModel>> signInWithEmailnPassword(
      String email, String password) async {
    try {
      final res = await authDataSrc.signInWithEmailnPassword(email, password);
      return Right(res);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, bool>> signOut() async {
    try {
      final res = await authDataSrc.signOut();
      return Right(res);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, UserModel>> signUpWithEmailnPassword(
      String email,
      String password,
      String name,
      String phone,
      String address,
      String gender,
      String dateOfBirth) async {
    try {
      final res = await authDataSrc.signUpWithEmailnPassword(
          email, password, name, phone, address, gender, dateOfBirth);
      return Right(res);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, UserModel>> signUpWithFacebook(
      {String? name,
      String? phone,
      String? address,
      String? gender,
      String? dateOfBirth}) async {
    try {
      final res = await authDataSrc.signUpWithFacebook(
          name: name,
          phone: phone,
          address: address,
          gender: gender,
          dateOfBirth: dateOfBirth);
      return Right(res);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Object, UserModel>> signUpWithGoogle(
      {String? name,
      String? phone,
      String? address,
      String? gender,
      String? dateOfBirth}) async {
    try {
      final res = await authDataSrc.signUpWithGoogle(
          name: name,
          phone: phone,
          address: address,
          gender: gender,
          dateOfBirth: dateOfBirth);
      return Right(res);
    } catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, UserModel>> getUser() async {
    try {
      final res = await authDataSrc.getUser();
      return Right(res);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, UserModel>> setUser(
    bool isFirst,
    String email,
  String phone,
  String address,
  String gender,
  String fullName,
  String dateOfBirth
  ) async {
    try {
      final res = await authDataSrc.setUser(isFirst,email, phone, address, gender, fullName, dateOfBirth);
      return right(res);
    } on Exception catch (e) {
      return Left(e);
    }
  }
}
