
import 'package:equatable/equatable.dart';

class ErrorMessageModel extends Equatable{
  final int statusCode;
  final String statueMessage;
  final bool success;

  const ErrorMessageModel({
    required this.statusCode,
    required this.statueMessage,
    required this.success
  });


  factory ErrorMessageModel.fromJson(Map<String,dynamic> json) => ErrorMessageModel(
      statusCode: json["status_code"],
      statueMessage: json["status_message"],
      success: json["success"]
  );

  @override
  List<Object?> get props => [
    statusCode,
    statueMessage,
    success
  ];
}