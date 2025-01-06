part of 'project_summary_bloc.dart';

abstract class ProjectSummaryState extends Equatable {
  const ProjectSummaryState();

  @override
  List<Object?> get props => [];
}

class ProjectSummaryInitial extends ProjectSummaryState {}

class ProjectSummaryLoading extends ProjectSummaryState {}

class ProjectSummaryLoaded extends ProjectSummaryState {
  final ProjectSummaryModel projectSummary;

  const ProjectSummaryLoaded(this.projectSummary);

  @override
  List<Object?> get props => [projectSummary];
}

class ProjectSummaryError extends ProjectSummaryState {
  final String message;

  const ProjectSummaryError(this.message);

  @override
  List<Object?> get props => [message];
}
