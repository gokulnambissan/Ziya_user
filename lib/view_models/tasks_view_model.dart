import 'package:flutter/material.dart';

class TaskDefinition {
  final String title;
  final String description;

  TaskDefinition({required this.title, required this.description});
}

class TasksViewModel {
  final List<TaskDefinition> tasks = [
    TaskDefinition(
      title: "UI/UX Design Implementation",
      description: "Translating design specifications into functional and visually appealing user interfaces using technologies like HTML, CSS, and JavaScript.",
    ),
    TaskDefinition(
      title: "Responsive Design",
      description: "Ensuring that the application adapts seamlessly to different screen sizes and devices.",
    ),
    TaskDefinition(
      title: "Backend Development",
      description: "Creating and managing databases for efficient data storage, retrieval and processing.",
    ),
    TaskDefinition(
      title: "Server-Side Logic",
      description: "Developing and maintaining the logic that runs on the server, handling user requests, processing data and interacting with databases.",
    ),
  ];

  Widget buildTaskCard(TaskDefinition task) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(task.title,
              style: const TextStyle(
                  color: Color.fromARGB(255, 30, 245, 37),
                  fontSize: 14,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.circle, size: 6),
              const SizedBox(width: 5),
              Expanded(
                child: Text(task.description,
                    style: const TextStyle(color: Colors.black87,fontSize: 11)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 14,vertical: 4),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
              ),
              child: const Text("Start",
              style: TextStyle(fontSize: 11),),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDottedDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: LayoutBuilder(builder: (context, constraints) {
        final width = constraints.maxWidth;
        const dotWidth = 4.0;
        const spacing = 4.0;
        final dotCount = (width / (dotWidth + spacing)).floor();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dotCount, (_) {
            return const SizedBox(
              width: dotWidth,
              height: 1,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.grey),
              ),
            );
          }),
        );
      }),
    );
  }
}
