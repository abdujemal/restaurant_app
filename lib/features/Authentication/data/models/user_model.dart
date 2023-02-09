// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:restaurant_app/features/Authentication/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  String uid;
  String email;
  String phone;
  String address;
  String gender;
  String fullName;
  String image;
  String dateOfBirth;
  List<dynamic> favourites;

  UserModel({
    required this.favourites,
    required this.uid,
    required this.email,
    required this.phone,
    required this.address,
    required this.gender,
    required this.fullName,
    required this.image,
    required this.dateOfBirth,
  }) : super(
            favourites: favourites,
            uid: uid,
            email: email,
            phone: phone,
            address: address,
            gender: gender,
            fullName: fullName,
            image: image,
            dataOfbirth: dateOfBirth);

  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      favourites: snapshot["favourites"],
        uid: snapshot["uid"],
        email: snapshot["email"],
        phone: snapshot["phone"],
        address: snapshot["address"],
        gender: snapshot["gender"],
        image: snapshot['image'],
        dateOfBirth: snapshot["dateOfBirth"],
        fullName: snapshot['fullName']);
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "phone": phone,
        "address": address,
        "gender": gender,
        "fullName": fullName,
        "image": image,
        "dateOfBirth": dataOfbirth,
        "favourites": favourites
      };
}
