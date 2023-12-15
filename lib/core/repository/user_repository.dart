import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fl_bloc_consumer/core/model/user_model.dart';
import 'package:fl_bloc_consumer/core/model/user_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/api_constant.dart';
import '../network/failure_model.dart';

///Repository class of user to handle user operations
class UserRepository {

  ///Method for register user
  Future<Either<FailureModel, UserModel?>> userRegistration({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      const url = ApiConstant.registration;

      final body = {"name": name, "email": email, "password": password};

      final response = await Dio().post(url, data: body);

      if (response.statusCode == 200) {
        final userResponse = UserResponseModel.fromJson(response.data);
        if (userResponse.code == 0) {
          return Right(userResponse.userData);
        } else {
          return Left(FailureModel(message: userResponse.message));
        }
      } else {
        return Left(FailureModel(message: response.data.toString()));
      }
    } catch (error) {
      return Left(FailureModel(message: error.toString()));
    }
  }

  ///Method for login user
  Future<Either<FailureModel, UserModel?>> userLogin({
    required String email,
    required String password,
  }) async {
    try {
      const url = ApiConstant.login;

      final body = {"email": email, "password": password};

      final response = await Dio().post(url, data: body);

      if (response.statusCode == 200) {
        final userResponse = UserResponseModel.fromJson(response.data);
        if (userResponse.code == 0) {
          final preference = await SharedPreferences.getInstance();
          preference.setBool(ApiConstant.isLogin, true);
          preference.setString(ApiConstant.userName, userResponse.userData?.name ?? '');
          return Right(userResponse.userData);
        } else {
          return Left(FailureModel(message: userResponse.message));
        }
      } else {
        return Left(FailureModel(message: response.data.toString()));
      }
    } catch (error) {
      return Left(FailureModel(message: error.toString()));
    }
  }
}
