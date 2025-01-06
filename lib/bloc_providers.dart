import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskify/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:taskify/features/home/presentation/bloc/project_summary_bloc.dart';

class BlocProviders {
  static List<BlocProvider> getAllProviders() {
    return [
      BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(
          RepositoryProvider.of(context),
        ),
      ),
      BlocProvider<ProjectSummaryBloc>(
        create: (context) => ProjectSummaryBloc(
          RepositoryProvider.of(context),
        ),
      ),
    ];
  }
}
