// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:restaurant_app/core/useCase/base_usecase.dart';
import 'package:restaurant_app/features/Authentication/domain/repo/auth_repo.dart';

import '../../data/models/user_model.dart';

class SetUserUseCase {
  AuthRepo authRepo;
  SetUserUseCase({
    required this.authRepo,
  });
  @override
  Future<Either<Exception, UserModel>> call(SetUserParameter parameter) async {
    return await authRepo.setUser(
        parameter.isFirst,
        parameter.email,
        parameter.phone,
        parameter.address,
        parameter.gender,
        parameter.fullName,
        parameter.dateOfBirth);
  }
}

class SetUserParameter extends Equatable {
  bool isFirst;
  String email;
  String phone;
  String address;
  String gender;
  String fullName;
  String dateOfBirth;
  SetUserParameter({
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
