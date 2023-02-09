import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restaurant_app/core/util/const.dart';
import 'package:restaurant_app/features/Authentication/data/data_source/auth_data_src.dart';
import 'package:restaurant_app/features/Authentication/data/models/user_model.dart';

class AuthDataSrcImpl extends AuthDataSrc {
  FirebaseAuth firebaseAuth;
  FirebaseFirestore firebaseFirestore;
  GoogleSignIn googleSignIn;
  FacebookAuth facebookAuth;

  AuthDataSrcImpl(this.firebaseAuth, this.firebaseFirestore, this.googleSignIn,
      this.facebookAuth);

  @override
  Future<bool> forgetPassword(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
    return true;
  }

  @override
  Future<UserModel> signInWithEmailnPassword(
      String email, String password) async {
    UserCredential cred = await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    String uid = cred.user!.uid;

    final usersnap =
        await firebaseFirestore.collection(FirebaseConst.users).doc(uid).get();
    if (usersnap.exists) {
      return UserModel.fromSnapshot(usersnap);
    } else {
      throw Exception("no user with this id.");
    }
  }

  @override
  Future<bool> signOut() async {
    bool isGoogle =
        firebaseAuth.currentUser!.providerData[0].providerId == "google.com";

    await firebaseAuth.signOut();
    if (isGoogle) {
      GoogleSignIn().signOut();
    }

    return true;
  }

  @override
  Future<UserModel> signUpWithEmailnPassword(
      String email,
      String password,
      String name,
      String phone,
      String address,
      String gender,
      String dateOfBirth) async {
    print("registering $email, $password");
    UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    String uid = cred.user!.uid;

    UserModel userModel = UserModel(
        favourites: const [],
        image: "",
        uid: uid,
        email: email,
        phone: phone,
        address: address,
        gender: gender,
        fullName: name,
        dateOfBirth: dateOfBirth);

    await firebaseFirestore
        .collection(FirebaseConst.users)
        .doc(uid)
        .set(userModel.toJson());

    return userModel;
  }

  @override
  Future<UserModel> signUpWithFacebook(
      {String? name,
      String? phone,
      String? address,
      String? gender,
      String? dateOfBirth}) async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await facebookAuth.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    UserCredential cred =
        await firebaseAuth.signInWithCredential(facebookAuthCredential);

    String uid = cred.user!.uid;

    final ds =
        await firebaseFirestore.collection(FirebaseConst.users).doc(uid).get();
    if (ds.exists) {
      UserModel userModel = UserModel.fromSnapshot(ds);
      return userModel;
    } else {
      print("registering...google");
      UserModel userModel = UserModel(
          favourites: const [],
          image: cred.user!.photoURL ?? "",
          uid: uid,
          email: cred.user!.email ?? "",
          phone: phone ?? "",
          address: address ?? "",
          gender: gender ?? "",
          fullName: name ?? "",
          dateOfBirth: dateOfBirth ?? "");
      await firebaseFirestore
          .collection(FirebaseConst.users)
          .doc(uid)
          .set(userModel.toJson());
      return userModel;
    }
  }

  @override
  Future<UserModel> signUpWithGoogle(
      {String? name,
      String? phone,
      String? address,
      String? gender,
      String? dateOfBirth}) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    UserCredential cred = await firebaseAuth.signInWithCredential(credential);

    String uid = cred.user!.uid;

    final ds =
        await firebaseFirestore.collection(FirebaseConst.users).doc(uid).get();
    if (ds.exists) {
      UserModel userModel = UserModel.fromSnapshot(ds);
      return userModel;
    } else {
      UserModel userModel = UserModel(
          favourites: const [],
          image: cred.user!.photoURL ?? "",
          uid: uid,
          email: cred.user!.email ?? "",
          phone: phone ?? "",
          address: address ?? "",
          gender: gender ?? "",
          fullName: name ?? "",
          dateOfBirth: dateOfBirth ?? "");
      await firebaseFirestore
          .collection(FirebaseConst.users)
          .doc(uid)
          .set(userModel.toJson());
      return userModel;
    }
  }

  @override
  Future<UserModel> getUser() async {
    User? user = firebaseAuth.currentUser;

    if (user != null) {
      final ds = await firebaseFirestore
          .collection(FirebaseConst.users)
          .doc(user.uid)
          .get();
      if (ds.exists) {
        UserModel userModel = UserModel.fromSnapshot(ds);
        return userModel;
      } else {
        throw Exception("user does not exist.");
      }
    } else {
      throw Exception("not sign up.");
    }
  }

  @override
  Future<UserModel> setUser(bool isFirst, String email, String phone, String address,
      String gender, String fullName, String dateOfBirth) async {
    User? user = firebaseAuth.currentUser;
    final data = {
      "email": email,
      "phone": phone,
      "address": address,
      "gender": gender,
      "fullName": fullName,
      "dateOfBirth": dateOfBirth
    };
    await firebaseFirestore
        .collection(FirebaseConst.users)
        .doc(user!.uid)
        .update(data);

    final userDs = await firebaseFirestore
        .collection(FirebaseConst.users)
        .doc(user.uid)
        .get();
    
    return UserModel.fromSnapshot(userDs);
  }
}
