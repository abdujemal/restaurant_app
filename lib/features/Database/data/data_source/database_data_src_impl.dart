import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restaurant_app/core/util/const.dart';
import 'package:restaurant_app/features/Authentication/presentation/bloc/login_controller/login_bloc.dart';
import 'package:restaurant_app/features/Database/data/data_source/database_data_src.dart';
import 'package:restaurant_app/features/Database/data/models/review_model.dart';
import 'package:restaurant_app/features/Database/data/models/food_model.dart';
import 'package:restaurant_app/injection.dart';

class DatabaseDataSrcImpl extends DatabaseDataSrc {
  FirebaseFirestore firebaseFirestore;
  FirebaseAuth firebaseAuth;
  DatabaseDataSrcImpl(this.firebaseFirestore, this.firebaseAuth);

  @override
  Future<List<FoodModel>> getFoods() async {
    String uid = firebaseAuth.currentUser!.uid;

    final dsUser =
        await firebaseFirestore.collection(FirebaseConst.users).doc(uid).get();

    final dsFoods =
        await firebaseFirestore.collection(FirebaseConst.foods).get();
    List<FoodModel> foods = [];

    for (var food in dsFoods.docs) {
      foods.add(FoodModel.fromFirebseMap(
          food.data(),
          (dsUser.data()!["favourites"] as List<dynamic>)
              .contains(food.data()["id"])));
    }

    return foods;
  }

  @override
  Future<List<ReviewModel>> getReviews(String foodID) async {
    final qsReviews = await firebaseFirestore
        .collection(FirebaseConst.reviews)
        .where("foodId", isEqualTo: foodID)
        .get();

    List<ReviewModel> reviews = [];

    for (var reviewDoc in qsReviews.docs) {
      if (reviewDoc.exists) {
        ReviewModel reviewModel = ReviewModel.fromSnapshot(reviewDoc);
        reviews.add(reviewModel);
      }
    }

    return reviews;
  }

  @override
  Future<void> placeAnOrder() {
    // TODO: implement placeAnOrder
    throw UnimplementedError();
  }

  @override
  Future<List<FoodModel>> searchFoods(String query) async {
    String uid = firebaseAuth.currentUser!.uid;

    final dsUser =
        await firebaseFirestore.collection(FirebaseConst.users).doc(uid).get();

    final dsFoods = await firebaseFirestore
        .collection(FirebaseConst.foods)
        // .orderBy("name")
        // .where("name", isLessThan: query)
        .where('name', isGreaterThanOrEqualTo: query)
        .get();

    List<FoodModel> foods = [];

    for (var foodDs in dsFoods.docs) {
      foods.add(FoodModel.fromFirebseMap(
          foodDs.data(),
          (dsUser.data()!["favourites"] as List<dynamic>)
              .contains(foodDs.data()["id"])));
    }
    return foods;
  }

  @override
  Future<bool> addToFavorite(FoodModel foodModel) async {
    String uid = firebaseAuth.currentUser!.uid;

    final dsUser =
        await firebaseFirestore.collection(FirebaseConst.users).doc(uid).get();

    await firebaseFirestore.collection(FirebaseConst.users).doc(uid).update({
      "favourites": [
        ...(dsUser.data()!["favourites"] as List<dynamic>),
        foodModel.id
      ]
    });

    return true;
  }

  @override
  Future<bool> removeToFavorite(FoodModel foodModel) async {
    String uid = firebaseAuth.currentUser!.uid;

    final dsUser =
        await firebaseFirestore.collection(FirebaseConst.users).doc(uid).get();

    await firebaseFirestore.collection(FirebaseConst.users).doc(uid).update({
      "favourites": (dsUser.data()!["favourites"] as List<dynamic>)
          .where((element) => element != foodModel.id)
          .toList()
    });

    return true;
  }

  @override
  Future<List<ReviewModel>> addReview(ReviewModel reviewModel) async {
    await firebaseFirestore
        .collection(FirebaseConst.reviews)
        .add(reviewModel.toFirebaseMap());
    final res = await getReviews(reviewModel.foodId);
    return res;
  }
}
