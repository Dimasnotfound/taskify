import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/project_summary_bloc.dart';

class DashboardPage extends StatelessWidget {
  final String token;

  const DashboardPage({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProjectSummaryBloc(
        RepositoryProvider.of(context),
      )..add(FetchProjectSummary(token)),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Dashboard',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 25,
            ),
          ),
        ),
        body: BlocBuilder<ProjectSummaryBloc, ProjectSummaryState>(
          builder: (context, state) {
            if (state is ProjectSummaryLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ProjectSummaryLoaded) {
              final summary = state.projectSummary;
              print('DEBUG: Summary in UI: $summary');

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Project Summary',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildSummaryCard(
                      context,
                      color: Colors.green[500]!,
                      count: summary.done,
                      label: 'Completed',
                      isFull: true,
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        children: [
                          _buildSummaryCard(
                            context,
                            color: Colors.blue[500]!,
                            count: summary.ready,
                            label: 'Ready',
                            isFull: false,
                          ),
                          _buildSummaryCard(
                            context,
                            color: Colors.deepOrange[500]!,
                            count: summary.inProgress,
                            label: 'In Progress',
                            isFull: false,
                          ),
                          _buildSummaryCard(
                            context,
                            color: Colors.red[500]!,
                            count: summary.onHold,
                            label: 'On Hold',
                            isFull: false,
                          ),
                          _buildSummaryCard(
                            context,
                            color: Colors.purple[500]!,
                            count: summary.inReview,
                            label: 'In Review',
                            isFull: false,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is ProjectSummaryError) {
              return Center(
                child: Text(
                  'Error: ${state.message}',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }

            return const Center(
              child: Text('Something went wrong'),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSummaryCard(
    BuildContext context, {
    required Color color,
    required int count,
    required String label,
    required bool isFull,
  }) {
    return Container(
      width: isFull ? double.infinity : null,
      height: isFull ? 130 : null,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$count',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
