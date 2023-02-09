import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_app/core/useCase/base_usecase.dart';
import 'package:restaurant_app/features/Database/data/models/food_model.dart';
import 'package:restaurant_app/features/Database/domain/repo/database_repo.dart';

class AddToFavUsecase {
  DatabaseRepo databaseRepo;
  AddToFavUsecase(this.databaseRepo);
  @override
  Future<Either<Exception, void>> call(AddToFavParams parameters) async {
    final res = await databaseRepo.addToFavorite(parameters.foodModel);
    return res;
  }
}

class AddToFavParams extends Equatable {
  FoodModel foodModel;
  AddToFavParams(this.foodModel);

  @override
  List<Object?> get props => [foodModel];
}
