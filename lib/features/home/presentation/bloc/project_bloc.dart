import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../auth/data/repositories/project_repository.dart';

part 'project_event.dart';
part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final ProjectRepository repository;

  ProjectBloc(this.repository) : super(ProjectInitial()) {
    on<FetchProjects>((event, emit) async {
      emit(ProjectLoading());
      try {
        final projects = await repository.fetchProjects(event.token);
        emit(ProjectLoaded(projects));
      } catch (e) {
        emit(ProjectError('Failed to load projects'));
      }
    });
  }
}
