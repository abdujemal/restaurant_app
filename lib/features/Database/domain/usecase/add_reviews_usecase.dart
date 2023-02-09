// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:restaurant_app/core/useCase/base_usecase.dart';
import 'package:restaurant_app/features/Database/data/models/review_model.dart';
import 'package:restaurant_app/features/Database/domain/repo/database_repo.dart';

class AddReviewsUseCase {
  DatabaseRepo databaseRepo;
  AddReviewsUseCase({
    required this.databaseRepo,
  });

  @override
  Future<Either<Exception, List<ReviewModel>>> call(AddReviewParams parameters) async {
    final res = await databaseRepo.addReview(parameters.reviewModel);
    return res;
  }
}

class AddReviewParams extends Equatable {
  ReviewModel reviewModel;
  AddReviewParams({
    required this.reviewModel,
  });

  @override
  List<Object?> get props => [reviewModel];
}
