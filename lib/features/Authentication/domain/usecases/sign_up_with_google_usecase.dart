import 'package:equatable/equatable.dart';
import 'package:restaurant_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:restaurant_app/core/useCase/base_usecase.dart';
import 'package:restaurant_app/features/Authentication/domain/repo/auth_repo.dart';

import '../../data/models/user_model.dart';

class SignUpWithGoogleUsecase{
  AuthRepo authRepo;
  SignUpWithGoogleUsecase(this.authRepo);
  @override
  Future<Either<Object, UserModel>> call(parameters) async {
    return await authRepo.signUpWithGoogle(
        name: parameters.name,
        phone: parameters.phone,
        address: parameters.address,
        gender: parameters.gender,
        dateOfBirth: parameters.dateOfBirth);
  }
}

class SignUpGoogleParameter extends Equatable {
  String? name, phone, address, gender, dateOfBirth;

  SignUpGoogleParameter({
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
