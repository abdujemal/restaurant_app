// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  String uid;
  String email;
  String phone;
  String address;
  String gender;
  String fullName;
  String image;
  String dataOfbirth;
  List<dynamic> favourites;
  UserEntity({
    required this.favourites,
    required this.dataOfbirth,
    required this.image,
    required this.uid,
    required this.email,
    required this.phone,
    required this.address,
    required this.gender,
    required this.fullName,
  });

  @override
  List<Object?> get props =>
      [uid, email, phone, address, gender, fullName, image, dataOfbirth, favourites];
}
