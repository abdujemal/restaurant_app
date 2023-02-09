// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:restaurant_app/core/error/failure.dart';
import 'package:restaurant_app/core/useCase/base_usecase.dart';
import 'package:restaurant_app/features/Database/domain/repo/database_repo.dart';

class SearchFoodUsecase {
  DatabaseRepo databaseRepo;
  SearchFoodUsecase(this.databaseRepo);
  @override
  Future<Either<Exception, dynamic>> call(SearchFoodParams parameters) async {
    final res = await databaseRepo.searchFoods(parameters.query);
    return res;
  }
}

class SearchFoodParams extends Equatable {
  String query;
  SearchFoodParams({
    required this.query,
  });

  @override
  List<Object?> get props => [query];
}
