import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/repositories/project_summary_repository.dart';
import '../../data/models/project_summary_model.dart';

part 'project_summary_event.dart';
part 'project_summary_state.dart';

class ProjectSummaryBloc
    extends Bloc<ProjectSummaryEvent, ProjectSummaryState> {
  final ProjectSummaryRepository repository;

  ProjectSummaryBloc(this.repository) : super(ProjectSummaryInitial()) {
    on<FetchProjectSummary>((event, emit) async {
      emit(ProjectSummaryLoading());
      try {
        final summary = await repository.fetchProjectSummary(event.token);
        emit(ProjectSummaryLoaded(summary));
      } catch (e) {
        emit(ProjectSummaryError(e.toString()));
      }
    });
  }
}
