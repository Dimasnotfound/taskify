import 'package:dio/dio.dart';

class ProjectRepository {
  final Dio client;

  ProjectRepository(this.client);

  Future<List<dynamic>> fetchProjects(String token) async {
    try {
      final response = await client.get(
        '/projects',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        return response.data as List<dynamic>;
      } else {
        throw Exception('Failed to load projects');
      }
    } catch (e) {
      throw Exception('Failed to load projects: $e');
    }
  }
}
