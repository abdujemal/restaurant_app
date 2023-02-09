import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:restaurant_app/features/Authentication/data/data_source/auth_data_src.dart';
import 'package:restaurant_app/features/Authentication/data/data_source/auth_data_src_impl.dart';
import 'package:restaurant_app/features/Authentication/data/repo/auth_repo_impl.dart';
import 'package:restaurant_app/features/Authentication/domain/repo/auth_repo.dart';
import 'package:restaurant_app/features/Authentication/domain/usecases/forget_password_usecase.dart';
import 'package:restaurant_app/features/Authentication/domain/usecases/get_user_usecase.dart';
import 'package:restaurant_app/features/Authentication/domain/usecases/set_user_usecase.dart';
import 'package:restaurant_app/features/Authentication/domain/usecases/sign_in_with_email_n_password.dart';
import 'package:restaurant_app/features/Authentication/domain/usecases/sign_out_usecase.dart';
import 'package:restaurant_app/features/Authentication/domain/usecases/sign_up_with_facebook_usecase.dart';
import 'package:restaurant_app/features/Authentication/domain/usecases/sign_up_with_google_usecase.dart';
import 'package:restaurant_app/features/Authentication/domain/usecases/signup_with_email_n_password_usecase.dart';
import 'package:restaurant_app/features/Authentication/presentation/bloc/login_controller/login_bloc.dart';
import 'package:restaurant_app/features/Database/data/data_source/database_data_src.dart';
import 'package:restaurant_app/features/Database/data/data_source/database_data_src_impl.dart';
import 'package:restaurant_app/features/Database/data/repo/database_repo_impl.dart';
import 'package:restaurant_app/features/Database/domain/repo/database_repo.dart';
import 'package:restaurant_app/features/Database/domain/usecase/add_reviews_usecase.dart';
import 'package:restaurant_app/features/Database/domain/usecase/add_to_favourites_usecase.dart';
import 'package:restaurant_app/features/Database/domain/usecase/get_foods_usecase.dart';
import 'package:restaurant_app/features/Database/domain/usecase/get_reviews_usecase.dart';
import 'package:restaurant_app/features/Database/domain/usecase/remove_from_favourite_usecase.dart';
import 'package:restaurant_app/features/Database/domain/usecase/search_foods_usecase.dart';
import 'package:restaurant_app/features/Database/presentation/controller/cart_controller/cart_bloc.dart';
import 'package:restaurant_app/features/Database/presentation/controller/food%20controlelr/food_bloc.dart';

final di = GetIt.instance;

void di_setup() {
  // bloc
  di.registerFactory(
      () => LoginBloc(di(), di(), di(), di(), di(), di(), di(), di()));
  di.registerFactory(() => CartBloc());
  di.registerFactory(() => FoodBloc(di(), di(), di(), di(), di(), di()));

  // usecase
  di.registerLazySingleton(() => ForgetPasswordUsecase(di()));
  di.registerLazySingleton(() => GetUserUsecase(di()));
  di.registerLazySingleton(() => SignInWithEmailnPasswordUsecase(di()));
  di.registerLazySingleton(() => SignOutUsecase(di()));
  di.registerLazySingleton(() => SignUpWithFacebookUsecase(di()));
  di.registerLazySingleton(() => SignUpWithGoogleUsecase(di()));
  di.registerLazySingleton(() => SignUpWithEmailnPasswordUsecase(di()));
  di.registerLazySingleton(() => SetUserUseCase(authRepo: di()));
  di.registerLazySingleton(() => GetFoodsUsecase(di()));
  di.registerLazySingleton(() => AddReviewsUseCase(databaseRepo: di()));
  di.registerLazySingleton(() => AddToFavUsecase(di()));
  di.registerLazySingleton(() => RemoveFromFavUsecase(di()));
  di.registerLazySingleton(() => SearchFoodUsecase(di()));
  di.registerLazySingleton(() => GetReviewsUseCase(di()));
  

  // repositories
  di.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(di()));
  di.registerLazySingleton<DatabaseRepo>(() => DatabaseRepoImpl(di()));

  // data src
  di.registerLazySingleton<AuthDataSrc>(
      () => AuthDataSrcImpl(di(), di(), di(), di()));
  di.registerLazySingleton<DatabaseDataSrc>(
      () => DatabaseDataSrcImpl(di(), di()));

  // Externals

  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  final googleAuth = GoogleSignIn();
  final facebookAuth = FacebookAuth.instance;

  di.registerLazySingleton(() => firebaseFirestore);
  di.registerLazySingleton(() => firebaseAuth);
  di.registerLazySingleton(() => googleAuth);
  di.registerLazySingleton(() => facebookAuth);

  // TODO: database
}

class FirebaseStorage {}
