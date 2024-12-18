import 'package:dartz/dartz.dart';

import '../../data/data_provider/local_data_source.dart';
import '../../data/data_provider/remote_data_source.dart';
import '../../data/models/auth/auth_state_model.dart';
import '../../data/models/auth/user_response_model.dart';
import '../../presentation/errors/exception.dart';
import '../../presentation/errors/failure.dart';

abstract class AuthRepository {
  Future<Either<dynamic, UserResponse>> login(AuthStateModel body);

  Future<Either<dynamic, bool>> checkUser(AuthStateModel body);

  Future<Either<dynamic, String>> sendOtp(AuthStateModel body);

  Future<Either<dynamic, String>> verifyOtp(AuthStateModel body);

  Future<Either<dynamic, String>> addUser(AuthStateModel body);

  Future<Either<Failure, String>> logout(String token);

}

class AuthRepositoryImpl implements AuthRepository {
  final RemoteDataSource remoteDataSources;
  final LocalDataSource localDataSources;

  AuthRepositoryImpl(
      {required this.remoteDataSources, required this.localDataSources});

  @override
  Future<Either<dynamic, UserResponse>> login(AuthStateModel body) async {
    try {
      final result = await remoteDataSources.login(body);
      // localDataSources.cacheUserResponse(result);
      final login = UserResponse.fromMap(result);
      return Right(login);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }


  @override
  Future<Either<Failure, String>> logout(String token) async {
    try {
      final logout = await remoteDataSources.logout(token);
      localDataSources.clearUserResponse();
      return Right(logout);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<dynamic, bool>> checkUser(AuthStateModel body) async{
    try {
      final result = await remoteDataSources.checkUser(body);
      return Right(result['success']);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<dynamic, String>> sendOtp(AuthStateModel body) async{
    try {
      final result = await remoteDataSources.sendOtp(body);
      return Right(result['message']);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<dynamic, String>> verifyOtp(AuthStateModel body) async{
    try {
      final result = await remoteDataSources.verifyOtp(body);
      return Right(result['message']);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }
  @override
  Future<Either<dynamic, String>> addUser(AuthStateModel body) async{
    try {
      final result = await remoteDataSources.addUser(body);
      return Right(result['message']);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }
}
