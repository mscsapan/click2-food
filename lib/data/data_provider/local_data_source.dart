import 'package:shared_preferences/shared_preferences.dart';

import '../../presentation/errors/exception.dart';
import '../../presentation/utils/k_string.dart';
import '../models/auth/user_response_model.dart';

abstract class LocalDataSource {
  bool checkOnBoarding();

  Future<bool> cachedOnBoarding();

  Future<bool> cacheUserResponse(UserResponse userResponseModel);

  UserResponse getExistingUserInfo();

  Future<bool> clearUserResponse();
}

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<bool> cachedOnBoarding() async {
    return sharedPreferences.setBool(KString.cachedOnBoardingKey, true);
  }

  @override
  bool checkOnBoarding() {
    final jsonString = sharedPreferences.getBool(KString.cachedOnBoardingKey);
    if (jsonString != null) {
      return true;
    } else {
      throw const DatabaseException('Not cached yet');
    }
  }

  @override
  Future<bool> cacheUserResponse(UserResponse userResponseModel) {
    return sharedPreferences.setString(
        KString.getExistingUserResponseKey, userResponseModel.toJson());
  }

  @override
  UserResponse getExistingUserInfo() {
    final jsonData =
        sharedPreferences.getString(KString.getExistingUserResponseKey);
    if (jsonData != null) {
      return UserResponse.fromJson(jsonData);
    } else {
      throw const DatabaseException('Not save users');
    }
  }

  @override
  Future<bool> clearUserResponse() {
    return sharedPreferences.remove(KString.getExistingUserResponseKey);
  }
}
