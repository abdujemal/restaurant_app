import 'package:equatable/equatable.dart';
import 'package:restaurant_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:restaurant_app/core/useCase/base_usecase.dart';
import 'package:restaurant_app/features/Authentication/data/data_source/auth_data_src.dart';
import 'package:restaurant_app/features/Authentication/domain/repo/auth_repo.dart';

class ForgetPasswordUsecase extends BaseUseCase {
  AuthRepo authRepo;
  ForgetPasswordUsecase(this.authRepo);
  @override
  Future<Either<Exception, bool>> call(parameters) async {
    return await authRepo.forgetPassword(parameters.email);
  }
}

class ForgetPasswordParameter extends Equatable {
  String email;
  ForgetPasswordParameter({required this.email});
  @override
  List<Object?> get props => [email];
}
