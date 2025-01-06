part of 'project_summary_bloc.dart';

abstract class ProjectSummaryEvent extends Equatable {
  const ProjectSummaryEvent();

  @override
  List<Object?> get props => [];
}

class FetchProjectSummary extends ProjectSummaryEvent {
  final String token;

  const FetchProjectSummary(this.token);

  @override
  List<Object?> get props => [token];
}
