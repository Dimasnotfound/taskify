import 'package:dio/dio.dart';
import '../models/project_summary_model.dart';

class ProjectSummaryRepository {
  final Dio client;

  ProjectSummaryRepository(this.client);

  Future<ProjectSummaryModel> fetchProjectSummary() async {
    try {
      final response = await client.get('/project-summary');

      if (response.statusCode == 200) {
        return ProjectSummaryModel.fromJson(response.data);
      } else {
        throw Exception('Failed to fetch project summary');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        final statusCode = e.response?.statusCode ?? 0;
        final errorMessage = e.response?.data['message'] ?? 'Unknown error';
        throw Exception('Error $statusCode: $errorMessage');
      } else {
        throw Exception('Failed to fetch project summary: ${e.message}');
      }
    } catch (e) {
      throw Exception('Failed to fetch project summary: $e');
    }
  }
}
