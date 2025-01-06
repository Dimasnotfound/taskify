import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskify/core/network/api_client.dart';
import 'package:taskify/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:taskify/features/auth/domain/usecases/login_usecase.dart';
import 'package:taskify/features/auth/data/datasources/auth_remote_datasource.dart';

class RepositoryProviders {
  static List<RepositoryProvider> getAllProviders(ApiClient apiClient) {
    final authDatasource = AuthRemoteDatasource(apiClient.getClient());
    final authRepository = AuthRepositoryImpl(authDatasource);
    final loginUseCase = LoginUseCase(authRepository);

    return [
      RepositoryProvider<AuthRepositoryImpl>.value(value: authRepository),
      RepositoryProvider<LoginUseCase>.value(value: loginUseCase),
    ];
  }
}
