import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:taskify/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:taskify/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:taskify/features/auth/data/repositories/project_repository.dart';
import 'package:taskify/features/auth/domain/usecases/login_usecase.dart';
import 'package:taskify/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:taskify/features/home/presentation/bloc/project_bloc.dart';
import 'core/network/api_client.dart';
import 'core/routes/app_routes.dart';
import 'core/routes/route_names.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  final apiClient = ApiClient();

  final projectRepository = ProjectRepository(apiClient.getClient());
  final authDatasource = AuthRemoteDatasource(apiClient.getClient());
  final authRepository = AuthRepositoryImpl(authDatasource);
  final loginUseCase = LoginUseCase(authRepository);

  runApp(MyApp(
    projectRepository: projectRepository,
    loginUseCase: loginUseCase,
  ));
}

class MyApp extends StatelessWidget {
  final ProjectRepository projectRepository;
  final LoginUseCase loginUseCase;

  const MyApp({
    super.key,
    required this.projectRepository,
    required this.loginUseCase,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ProjectRepository>.value(value: projectRepository),
        RepositoryProvider<LoginUseCase>.value(value: loginUseCase),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              RepositoryProvider.of<LoginUseCase>(context),
            ),
          ),
          BlocProvider<ProjectBloc>(
            create: (context) => ProjectBloc(
              RepositoryProvider.of<ProjectRepository>(context),
            ),
          ),
        ],
        child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: RouteNames.splash,
              onGenerateRoute: AppRoutes.generateRoute,
            );
          },
        ),
      ),
    );
  }
}
