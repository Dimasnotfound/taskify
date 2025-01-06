class ProjectSummaryModel {
  final int ready;
  final int inProgress;
  final int onHold;
  final int inReview;
  final int done;

  ProjectSummaryModel({
    required this.ready,
    required this.inProgress,
    required this.onHold,
    required this.inReview,
    required this.done,
  });

  factory ProjectSummaryModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    return ProjectSummaryModel(
      ready: data['ready'] ?? 0,
      inProgress: data['in_progress'] ?? 0,
      onHold: data['on_hold'] ?? 0,
      inReview: data['in_review'] ?? 0,
      done: data['done'] ?? 0,
    );
  }
}
