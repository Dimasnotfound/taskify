import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  int selectedFilterIndex = 0;

  final List<Map<String, dynamic>> filters = [
    {'label': 'Ready', 'count': 10},
    {'label': 'In Progress', 'count': 8},
    {'label': 'On Hold', 'count': 5},
    {'label': 'In Review', 'count': 3},
    {'label': 'Completed', 'count': 65},
  ];

  final List<Map<String, dynamic>> tasks = [
    {
      'title': 'Dashboard design for admin',
      'priority': 'High',
      'status': 'Ready',
      'color': Colors.blue,
      'date': '14 Oct 2022',
      'comments': 5,
      'attachments': 5,
    },
    {
      'title': 'Konom web application',
      'priority': 'Low',
      'status': 'In Progress',
      'color': Colors.deepOrange,
      'date': '14 Nov 2022',
      'comments': 2,
      'attachments': 4,
    },
    {
      'title': 'Research and development',
      'priority': 'Medium',
      'status': 'On Hold',
      'color': Colors.red,
      'date': '14 Oct 2022',
      'comments': 6,
      'attachments': 2,
    },
    {
      'title': 'Event booking application',
      'priority': 'Medium',
      'status': 'In Review',
      'color': Colors.purple,
      'date': '14 Oct 2022',
      'comments': 6,
      'attachments': 3,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final selectedFilter = filters[selectedFilterIndex]['label'];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Task List"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add_circle_outline),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Filter buttons
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filters.length,
                itemBuilder: (context, index) {
                  final filter = filters[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: FilterButton(
                      label: filter['label'],
                      count: filter['count'],
                      isSelected: selectedFilterIndex == index,
                      onTap: () {
                        setState(() {
                          selectedFilterIndex = index;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            // Task list
            Expanded(
              child: ListView(
                children: tasks
                    .where((task) => task['status'] == selectedFilter)
                    .map((task) => TaskCard(
                          title: task['title'],
                          priority: task['priority'],
                          status: task['status'],
                          color: task['color'],
                          date: task['date'],
                          comments: task['comments'],
                          attachments: task['attachments'],
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final String label;
  final int count;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterButton({
    super.key,
    required this.label,
    required this.count,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              count.toString(),
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final String title;
  final String priority;
  final String status;
  final Color color;
  final String date;
  final int comments;
  final int attachments;

  const TaskCard({
    super.key,
    required this.title,
    required this.priority,
    required this.status,
    required this.color,
    required this.date,
    required this.comments,
    required this.attachments,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(Icons.more_vert, color: Colors.grey[600]),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Chip(
                  label: Text(priority),
                  backgroundColor: color.withOpacity(0.2),
                  labelStyle:
                      TextStyle(color: color, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                Chip(
                  label: Text(status),
                  backgroundColor: Colors.grey[200],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Row(
                  children: [
                    Icon(Icons.comment, color: Colors.grey, size: 16),
                    const SizedBox(width: 4),
                    Text(comments.toString()),
                    const SizedBox(width: 16),
                    Icon(Icons.attach_file, color: Colors.grey, size: 16),
                    const SizedBox(width: 4),
                    Text(attachments.toString()),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
