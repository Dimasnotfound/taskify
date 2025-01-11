import 'package:flutter/material.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FilterButton(label: "Complete", count: 65, isSelected: true),
                FilterButton(label: "To Do", count: 45),
                FilterButton(label: "In Review", count: 3),
              ],
            ),
            const SizedBox(height: 16),
            // Task list
            Expanded(
              child: ListView(
                children: const [
                  TaskCard(
                    title: "Dashboard design for admin",
                    priority: "High",
                    status: "On Track",
                    color: Colors.pink,
                    date: "14 Oct 2022",
                    comments: 5,
                    attachments: 5,
                  ),
                  TaskCard(
                    title: "Konom web application",
                    priority: "Low",
                    status: "Meeting",
                    color: Colors.lightGreen,
                    date: "14 Nov 2022",
                    comments: 2,
                    attachments: 4,
                  ),
                  TaskCard(
                    title: "Research and development",
                    priority: "Medium",
                    status: "At Risk",
                    color: Colors.green,
                    date: "14 Oct 2022",
                    comments: 6,
                    attachments: 2,
                  ),
                  TaskCard(
                    title: "Event booking application",
                    priority: "Medium",
                    status: "Meeting",
                    color: Colors.orange,
                    date: "14 Oct 2022",
                    comments: 6,
                    attachments: 3,
                  ),
                ],
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

  const FilterButton({
    super.key,
    required this.label,
    required this.count,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
