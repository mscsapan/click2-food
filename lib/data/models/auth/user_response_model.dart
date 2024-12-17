import 'dart:convert';

import 'package:equatable/equatable.dart';

/*class UserResponseModel extends Equatable {
  final String accessToken;
  final String tokenType;
  final int isVendor;
  final int expireIn;
  final UserResponse? user;

  const UserResponseModel({
    required this.accessToken,
    required this.tokenType,
    required this.isVendor,
    required this.expireIn,
    required this.user,
  });

  UserResponseModel copyWith({
    String? accessToken,
    String? tokenType,
    int? isVendor,
    int? expireIn,
    UserResponse? user,
  }) {
    return UserResponseModel(
      accessToken: accessToken ?? this.accessToken,
      tokenType: tokenType ?? this.tokenType,
      isVendor: isVendor ?? this.isVendor,
      expireIn: expireIn ?? this.expireIn,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'access_token': accessToken,
      'token_type': tokenType,
      'is_vendor': isVendor,
      'expires_in': expireIn,
      'user': user!.toMap(),
    };
  }

  factory UserResponseModel.fromMap(Map<String, dynamic> map) {
    return UserResponseModel(
      accessToken: map['access_token'] ?? '',
      tokenType: map['token_type'] ?? '',
      isVendor: map['is_vendor'] ?? 0,
      expireIn: map['expires_in'] ?? 0,
      user: map['user'] != null
          ? UserResponse.fromMap(map['user'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserResponseModel.fromJson(String source) =>
      UserResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      accessToken,
      tokenType,
      isVendor,
      expireIn,
      user!,
    ];
  }
}*/

class UserResponse extends Equatable {
  final bool isAuthenticated;
  final String id;
  final String userFName;
  final String userLName;
  final String phoneNumber;
  final String userName;
  final String tokenString;
  final String refreshToken;

  const UserResponse({
    required this.isAuthenticated,
    required this.id,
    required this.userFName,
    required this.userLName,
    required this.phoneNumber,
    required this.userName,
    required this.tokenString,
    required this.refreshToken,
  });

  UserResponse copyWith({
    bool? isAuthenticated,
    String? id,
    String? userFName,
    String? userLName,
    String? phoneNumber,
    String? userName,
    String? tokenString,
    String? refreshToken,
  }) {
    return UserResponse(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      id: id ?? this.id,
      userFName: userFName ?? this.userFName,
      userLName: userLName ?? this.userLName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      userName: userName ?? this.userName,
      tokenString: tokenString ?? this.tokenString,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isAuthenticated': isAuthenticated,
      'id': id,
      'userFName': userFName,
      'userLName': userLName,
      'phoneNumber': phoneNumber,
      'userName': userName,
      'tokenString': tokenString,
      'refreshToken': refreshToken,
    };
  }

  factory UserResponse.fromMap(Map<String, dynamic> map) {
    return UserResponse(
      isAuthenticated: map['isAuthenticated'] ?? false,
      id: map['id'] ?? '',
      userFName: map['userFName'] ?? '',
      userLName: map['userLName'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      userName: map['userName'] ?? '',
      tokenString: map['tokenString'] ?? '',
      refreshToken: map['refreshToken'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserResponse.fromJson(String source) =>
      UserResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      isAuthenticated,
      id,
      userFName,
      userLName,
      phoneNumber,
      userName,
      tokenString,
      refreshToken,
    ];
  }
}
