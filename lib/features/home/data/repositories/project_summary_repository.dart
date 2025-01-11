import 'package:dio/dio.dart';
import '../models/project_summary_model.dart';

class ProjectSummaryRepository {
  final Dio client;

  ProjectSummaryRepository(this.client);

  Future<ProjectSummaryModel> fetchProjectSummary() async {
    try {
      final response = await client.get('/project-summary');

      if (response.statusCode == 200 && response.data != null) {
        return ProjectSummaryModel.fromJson(response.data);
      } else {
        throw Exception(
            'Failed to fetch project summary with status code ${response.statusCode}');
      }
    } on DioException catch (dioError) {
      throw Exception('DioException: ${dioError.message}');
    } catch (e) {
      throw Exception('Failed to fetch project summary: $e');
    }
  }
}
