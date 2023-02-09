// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:restaurant_app/core/error/failure.dart';
import 'package:restaurant_app/core/useCase/base_usecase.dart';
import 'package:restaurant_app/features/Authentication/domain/repo/auth_repo.dart';

import '../../data/models/user_model.dart';

class SignUpWithFacebookUsecase extends BaseUseCase {
  AuthRepo authRepo;
  SignUpWithFacebookUsecase(this.authRepo);
  @override
  Future<Either<Exception, UserModel>> call(parameters) async {
    return await authRepo.signUpWithFacebook(
        name: parameters.name,
        phone: parameters.phone,
        address: parameters.address,
        gender: parameters.gender
        );
  }
}

class SignUpFacebookParameter extends Equatable {
  String? name, phone, address, gender, dateOfBirth;

  SignUpFacebookParameter({
    this.address,
    this.name,
    this.phone,
    this.gender,
    this.dateOfBirth
  });
  
  
  
  @override
  List<Object?> get props => [
    name,
    phone,
    address,
    gender,
    dateOfBirth
  ];
}
