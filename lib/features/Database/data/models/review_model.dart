// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:restaurant_app/features/Database/domain/entities/review_entity.dart';

class ReviewModel extends ReviewEntity {
  String image;
  String date;
  String name;
  String text;
  String id;
  String foodId;

  ReviewModel({
    required this.image,
    required this.date,
    required this.name,
    required this.text,
    required this.id,
    required this.foodId,
  }) : super(
            image: image,
            date: date,
            name: name,
            text: text,
            id: id,
            foodId: foodId);

  ReviewModel copyWith({
    String? image,
    String? date,
    String? name,
    String? text,
    String? id,
    String? foodId,
  }) {
    return ReviewModel(
      image: image ?? this.image,
      date: date ?? this.date,
      name: name ?? this.name,
      text: text ?? this.text,
      id: id ?? this.id,
      foodId: foodId ?? this.foodId,
    );
  }

  factory ReviewModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return ReviewModel(
        image: snapshot["image"],
        date: snapshot["date"],
        name: snapshot["name"],
        text: snapshot["text"],
        id: snap.id,
        foodId: snapshot["foodId"]);
  }

  factory ReviewModel.fromFirebseMap(
      Map<String, dynamic> snapshot, String id) {
    return ReviewModel(
        image: snapshot["image"],
        date: snapshot["date"],
        name: snapshot["name"],
        text: snapshot["text"],
        id: id,
        foodId: snapshot["foodId"]);
  }

  Map<String, dynamic> toFirebaseMap() {
    return {
      "image": image,
      "date": date,
      "name": name,
      "text": text,
      "foodId": foodId
    };
  }
}
