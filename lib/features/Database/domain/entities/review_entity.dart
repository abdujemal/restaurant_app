// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ReviewEntity extends Equatable {
  String image;
  String date;
  String name;
  String text;
  String id;
  String foodId;
  ReviewEntity({
    required this.image,
    required this.date,
    required this.name,
    required this.text,
    required this.id,
    required this.foodId,
  });

  @override
  List<Object?> get props => [image, date, name, text, id, foodId];
}
