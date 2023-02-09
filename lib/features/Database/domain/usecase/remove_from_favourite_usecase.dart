// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:restaurant_app/features/Database/data/models/food_model.dart';
import 'package:restaurant_app/features/Database/domain/repo/database_repo.dart';

class RemoveFromFavUsecase {
  DatabaseRepo databaseRepo;
  RemoveFromFavUsecase(this.databaseRepo);
  @override
  Future<Either<Exception, dynamic>> call(
      RemoveFromFavParams parameters) async {
    final res = await databaseRepo.removeToFavorite(parameters.foodModel);
    return res;
  }
}

class RemoveFromFavParams extends Equatable {
  FoodModel foodModel;
  RemoveFromFavParams({
    required this.foodModel,
  });

  @override
  List<Object?> get props => [foodModel];
}
