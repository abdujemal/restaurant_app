import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/core/useCase/base_usecase.dart';
import 'package:restaurant_app/core/util/const.dart';
import 'package:restaurant_app/features/Database/data/models/food_model.dart';
import 'package:restaurant_app/features/Database/data/models/review_model.dart';
import 'package:restaurant_app/features/Database/domain/repo/database_repo.dart';
import 'package:restaurant_app/features/Database/domain/usecase/add_reviews_usecase.dart';
import 'package:restaurant_app/features/Database/domain/usecase/add_to_favourites_usecase.dart';
import 'package:restaurant_app/features/Database/domain/usecase/get_foods_usecase.dart';
import 'package:restaurant_app/features/Database/domain/usecase/get_reviews_usecase.dart';
import 'package:restaurant_app/features/Database/domain/usecase/place_an_order_usecase.dart';
import 'package:restaurant_app/features/Database/domain/usecase/remove_from_favourite_usecase.dart';
import 'package:restaurant_app/features/Database/domain/usecase/search_foods_usecase.dart';

part 'food_event.dart';
part 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  AddReviewsUseCase addReviewsUseCase;
  AddToFavUsecase addToFavUsecase;
  GetFoodsUsecase getFoodsUsecase;
  GetReviewsUseCase getReviewsUseCase;
  RemoveFromFavUsecase removeFromFavUsecase;
  SearchFoodUsecase searchFoodUsecase;

  FoodBloc(this.addReviewsUseCase, this.addToFavUsecase, this.getFoodsUsecase,
      this.getReviewsUseCase, this.removeFromFavUsecase, this.searchFoodUsecase)
      : super(FoodState()) {
    on<GetFoodsEvent>((event, emit) async {
      emit(state.copyWith(foodState: RequestState.loading));

      final result = await getFoodsUsecase.call(NoParameters());

      result.fold(
          (l) => emit(state.copyWith(
              foodState: RequestState.error, foodsError: l.toString())),
          (r) =>
              emit(state.copyWith(foodState: RequestState.loaded, foods: r)));
    });

    on<AddToFavouriteEvent>((event, emit) async {
      emit(state.copyWith(foodFavState: RequestState.loading));

      final result =
          await addToFavUsecase.call(AddToFavParams(event.foodModel));

      result.fold(
          (l) => emit(state.copyWith(
              foodFavState: RequestState.error, foodFavError: l.toString())),
          (r) => emit(state.copyWith(foodFavState: RequestState.loaded)));

      emit(state.copyWith(foodFavState: RequestState.idle));
    });

    on<RemoveToFavouriteEvent>((event, emit) async {
      emit(state.copyWith(foodFavState: RequestState.loading));

      final result = await removeFromFavUsecase
          .call(RemoveFromFavParams(foodModel: event.foodModel));

      result.fold(
          (l) => emit(state.copyWith(
              foodFavState: RequestState.error, foodFavError: l.toString())),
          (r) => emit(state.copyWith(foodFavState: RequestState.loaded)));

      emit(state.copyWith(foodFavState: RequestState.idle));
    });

    on<SearchFoodsEvent>((event, emit) async {
      emit(state.copyWith(searchFoodsState: RequestState.loading));

      final res =
          await searchFoodUsecase.call(SearchFoodParams(query: event.query));

      res.fold(
          (l) => emit(state.copyWith(
              searchFoodsError: l.toString(),
              searchFoodsState: RequestState.error)),
          (r) => emit(state.copyWith(
              searchFoods: r, searchFoodsState: RequestState.loaded)));
    });

    on<AddReviewEvent>((event, emit) async {
      emit(state.copyWith(addReviewState: RequestState.loading));

      final res = await addReviewsUseCase
          .call(AddReviewParams(reviewModel: event.reviewModel));

      res.fold(
          (l) => emit(state.copyWith(
              reviewError: l.toString(), addReviewState: RequestState.error)),
          (r) => emit(
              state.copyWith(addReviewState: RequestState.loaded, reviews: r)));

      emit(state.copyWith(addReviewState: RequestState.idle));
    });

    on<GetReviewEvent>((event, emit) async {
      emit(state.copyWith(reviewState: RequestState.loading));

      final res = await getReviewsUseCase.call(GetReviewsParams(event.foodId));

      res.fold(
          (l) => emit(state.copyWith(
              reviewState: RequestState.error, reviewError: l.toString())),
          (r) => emit(
              state.copyWith(reviewState: RequestState.loaded, reviews: r)));
    });
  }
}
