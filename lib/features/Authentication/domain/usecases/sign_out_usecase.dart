import 'package:restaurant_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:restaurant_app/core/useCase/base_usecase.dart';
import 'package:restaurant_app/features/Authentication/domain/repo/auth_repo.dart';

class SignOutUsecase extends BaseUseCase {
  AuthRepo authRepo;
  SignOutUsecase(this.authRepo);
  @override
  Future<Either<Exception, bool>> call(parameters) async {
    return await authRepo.signOut();
  }
}
