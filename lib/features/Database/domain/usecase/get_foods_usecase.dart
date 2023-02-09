import 'package:restaurant_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:restaurant_app/core/useCase/base_usecase.dart';
import 'package:restaurant_app/features/Database/data/models/food_model.dart';
import 'package:restaurant_app/features/Database/domain/repo/database_repo.dart';

class GetFoodsUsecase extends BaseUseCase {
  DatabaseRepo databaseRepo;
  GetFoodsUsecase(this.databaseRepo);
  @override
  Future<Either<Exception, List<FoodModel>>> call(parameters) async {
    final res = await databaseRepo.getFoods();
    return res;
  }
}
