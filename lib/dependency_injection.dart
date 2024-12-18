import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dependency_injection_packages.dart';
import 'logic/bloc/auth/auth_bloc.dart';
import 'logic/bloc/otp/otp_bloc.dart';

class DInjector {
  static late final SharedPreferences _sharedPreferences;

  static Future<void> initDB() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static final repositoryProvider = <RepositoryProvider>[
    RepositoryProvider<Client>(
      create: (context) => Client(),
    ),
    RepositoryProvider<SharedPreferences>(
      create: (context) => _sharedPreferences,
    ),
    RepositoryProvider<RemoteDataSource>(
      create: (context) => RemoteDataSourceImpl(
        client: context.read(),
      ),
    ),
    RepositoryProvider<LocalDataSource>(
      create: (context) => LocalDataSourceImpl(
        sharedPreferences: context.read(),
      ),
    ),
    RepositoryProvider<AuthRepository>(
      create: (context) => AuthRepositoryImpl(
        remoteDataSources: context.read(),
        localDataSources: context.read(),
      ),
    ),
  ];

  static final blocProviders = <BlocProvider>[

    BlocProvider<AuthBloc>(
      create: (BuildContext context) => AuthBloc(
        repository: context.read(),
      ),
    ),

    BlocProvider<OtpBloc>(
      create: (BuildContext context) => OtpBloc(
        repository: context.read(),
      ),
    ),

    // BlocProvider<PasswordChangeCubit>(
    //   create: (BuildContext context) => PasswordChangeCubit(
    //     sellerProfileRepository: context.read(),
    //     loginBloc: context.read(),
    //   ),
    // ),

    // BlocProvider<PasswordCubit>(
    //   create: (BuildContext context) => PasswordCubit(),
    // ),
  ];
}
