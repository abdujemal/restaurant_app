import 'package:equatable/equatable.dart';
import 'package:restaurant_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:restaurant_app/core/useCase/base_usecase.dart';
import 'package:restaurant_app/features/Authentication/data/models/user_model.dart';
import 'package:restaurant_app/features/Authentication/domain/repo/auth_repo.dart';

class SignUpWithEmailnPasswordUsecase extends BaseUseCase {
  AuthRepo authRepo;
  SignUpWithEmailnPasswordUsecase(this.authRepo);
  @override
  Future<Either<Exception, UserModel>> call(parameters) async {
    return await authRepo.signUpWithEmailnPassword(
        parameters.email,
        parameters.password,
        parameters.name,
        parameters.phone,
        parameters.address,
        parameters.gender,
        parameters.dateOfBirth);
  }
}

class SignUpWEmailPasswordParameters extends Equatable {
  String email, password, name, phone, address, gender, dateOfBirth;
  SignUpWEmailPasswordParameters(this.email, this.password, this.name,
      this.phone, this.address, this.gender, this.dateOfBirth);

  @override
  List<Object?> get props => [address, email, gender, name, password, phone];
}
