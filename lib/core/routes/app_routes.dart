import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskify/features/auth/presentation/pages/login_page.dart';
import 'package:taskify/features/auth/presentation/pages/splash_page.dart';
import 'package:taskify/features/home/presentation/bloc/project_bloc.dart';
import 'package:taskify/features/home/presentation/pages/home_page.dart';
import '../routes/route_names.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashPage(),
        );
      case RouteNames.login:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
        );
      case RouteNames.home:
        final token = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => ProjectBloc(
              RepositoryProvider.of(context),
            ),
            child: HomePage(token: token),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Page not found')),
          ),
        );
    }
  }
}
