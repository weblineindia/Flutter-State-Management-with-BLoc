import 'package:fl_bloc_consumer/core/model/user_model.dart';

/// Model class to hold user response data
class UserResponseModel {
  final UserModel? userData;
  final int code;
  final String message;

  const UserResponseModel({
    required this.userData,
    required this.code,
    required this.message,
  });

  ///constructor to parse json data and return UserResponse Model Instance
  factory UserResponseModel.fromJson(Map<String, dynamic> json) {
    return UserResponseModel(
      userData: json['data'] == null ? null : UserModel.fromJson(json['data']),
      code: json['code'],
      message: json['message'],
    );
  }
}
