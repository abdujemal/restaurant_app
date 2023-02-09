import 'package:restaurant_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:restaurant_app/core/useCase/base_usecase.dart';
import 'package:restaurant_app/features/Authentication/data/data_source/auth_data_src.dart';
import 'package:restaurant_app/features/Authentication/data/models/user_model.dart';
import 'package:restaurant_app/features/Authentication/domain/repo/auth_repo.dart';

class GetUserUsecase extends BaseUseCase {
  AuthRepo authRepo;
  GetUserUsecase(this.authRepo);
  @override
  Future<Either<Exception, UserModel>> call(parameters) async {
    return await authRepo.getUser();
  }
}
