import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/project_bloc.dart';

class DashboardPage extends StatelessWidget {
  final String token;

  const DashboardPage({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProjectBloc(
        RepositoryProvider.of(context),
      )..add(FetchProjects(token)),
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
        body: Padding(
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
                color: Colors.green[600]!,
                count: 45,
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
                      color: Colors.blue[600]!,
                      count: 10,
                      label: 'Ready',
                      isFull: false,
                    ),
                    _buildSummaryCard(
                      context,
                      color: Colors.deepOrange[600]!,
                      count: 24,
                      label: 'In Progress',
                      isFull: false,
                    ),
                    _buildSummaryCard(
                      context,
                      color: Colors.red[600]!,
                      count: 12,
                      label: 'On Hold',
                      isFull: false,
                    ),
                    _buildSummaryCard(
                      context,
                      color: Colors.purple[600]!,
                      count: 8,
                      label: 'In Review',
                      isFull: false,
                    ),
                  ],
                ),
              ),
            ],
          ),
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
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isFull
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
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
                  const Icon(
                    Icons.more_horiz,
                    color: Colors.white,
                  ),
                ],
              )
            : Stack(
                children: [
                  Column(
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
                  Positioned(
                    top: 8,
                    right: 8,
                    child: const Icon(
                      Icons.more_horiz,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
