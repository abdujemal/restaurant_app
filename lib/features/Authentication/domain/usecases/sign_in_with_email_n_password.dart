import 'package:equatable/equatable.dart';
import 'package:restaurant_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:restaurant_app/core/useCase/base_usecase.dart';
import 'package:restaurant_app/features/Authentication/data/models/user_model.dart';
import 'package:restaurant_app/features/Authentication/domain/repo/auth_repo.dart';

class SignInWithEmailnPasswordUsecase extends BaseUseCase {
  AuthRepo authRepo;
  SignInWithEmailnPasswordUsecase(this.authRepo);

  @override
  Future<Either<Exception, UserModel>> call(parameters) async {
    return await authRepo.signInWithEmailnPassword(
        parameters.email, parameters.password);
  }
}

class SignInWithEmailPasswordParameter extends Equatable {
  String email, password;
  SignInWithEmailPasswordParameter(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}
