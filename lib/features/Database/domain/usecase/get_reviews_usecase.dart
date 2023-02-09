import 'package:equatable/equatable.dart';
import 'package:restaurant_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:restaurant_app/core/useCase/base_usecase.dart';
import 'package:restaurant_app/features/Database/data/models/review_model.dart';
import 'package:restaurant_app/features/Database/domain/repo/database_repo.dart';

class GetReviewsUseCase {
  DatabaseRepo databaseRepo;
  GetReviewsUseCase(this.databaseRepo);

  @override
  Future<Either<Exception, List<ReviewModel>>> call(GetReviewsParams parameters) async {
    final res = await databaseRepo.getReviews(parameters.foodId);
    return res;
  }
}

class GetReviewsParams extends Equatable {
  String foodId;
  GetReviewsParams(this.foodId);

  @override
  List<Object?> get props => [foodId];
}
