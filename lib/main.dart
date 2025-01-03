import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'core/network/api_client.dart';
import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/pages/splash_page.dart';
import 'features/auth/presentation/pages/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  final apiClient = ApiClient();
  final authDatasource = AuthRemoteDatasource(apiClient.getClient());
  final authRepository = AuthRepositoryImpl(authDatasource);
  final loginUseCase = LoginUseCase(authRepository);

  runApp(MyApp(loginUseCase: loginUseCase));
}

class MyApp extends StatelessWidget {
  final LoginUseCase loginUseCase;

  const MyApp({Key? key, required this.loginUseCase}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(loginUseCase),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (_) => const SplashPage(),
          '/login': (_) => const LoginPage(),
        },
      ),
    );
  }
}
