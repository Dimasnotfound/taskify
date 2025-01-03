part of 'project_bloc.dart';

abstract class ProjectEvent extends Equatable {
  const ProjectEvent();

  @override
  List<Object> get props => [];
}

class FetchProjects extends ProjectEvent {
  final String token;

  const FetchProjects(this.token);

  @override
  List<Object> get props => [token];
}
