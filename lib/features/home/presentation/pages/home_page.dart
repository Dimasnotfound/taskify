import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/project_bloc.dart';

class HomePage extends StatelessWidget {
  final String token;

  const HomePage({Key? key, required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProjectBloc(
        RepositoryProvider.of(context),
      )..add(FetchProjects(token)),
      child: Scaffold(
        appBar: AppBar(title: const Text('Home')),
        body: BlocBuilder<ProjectBloc, ProjectState>(
          builder: (context, state) {
            if (state is ProjectLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProjectLoaded) {
              if (state.projects.isEmpty) {
                return const Center(child: Text('No projects found'));
              }
              return ListView.builder(
                itemCount: state.projects.length,
                itemBuilder: (context, index) {
                  final project = state.projects[index];
                  return ListTile(
                    title: Text(project['name']),
                    subtitle: Text(project['description'] ?? 'No description'),
                  );
                },
              );
            } else if (state is ProjectError) {
              return Center(child: Text(state.message));
            }

            return const Center(child: Text('Something went wrong'));
          },
        ),
      ),
    );
  }
}
