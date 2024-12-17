import 'package:dartz/dartz.dart';

import '../../data/data_provider/local_data_source.dart';
import '../../data/data_provider/remote_data_source.dart';
import '../../data/models/auth/auth_state_model.dart';
import '../../data/models/auth/user_response_model.dart';
import '../../presentation/errors/exception.dart';
import '../../presentation/errors/failure.dart';

abstract class AuthRepository {
  Future<Either<dynamic, UserResponse>> login(AuthStateModel body);

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
}
