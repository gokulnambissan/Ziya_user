import 'package:flutter/material.dart';

class WorkSummaryPage extends StatefulWidget {
  const WorkSummaryPage({super.key});

  @override
  State<WorkSummaryPage> createState() => _WorkSummaryPageState();
}

class _WorkSummaryPageState extends State<WorkSummaryPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.3,
            children: [
              /// Total Working Days
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 6,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Icon(Icons.calendar_today, color: Colors.teal),
                    SizedBox(height: 12),
                    Text("Total Working Days",
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                    SizedBox(height: 8),
                    Text("20",
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),

              /// Total Hours Worked
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 6,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Icon(Icons.access_time, color: Colors.teal),
                    SizedBox(height: 12),
                    Text("Total Hours worked",
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                    SizedBox(height: 8),
                    Text("160 hours",
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),

              /// Average Daily Hours
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 6,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Icon(Icons.av_timer, color: Colors.teal),
                    SizedBox(height: 12),
                    Text("Average Daily Hours",
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                    SizedBox(height: 8),
                    Text("8.0 hours",
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),

              /// Productivity Indicator
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 6,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Icon(Icons.bar_chart, color: Colors.teal),
                    SizedBox(height: 12),
                    Text("Productivity Indicator",
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                    SizedBox(height: 8),
                    Text("80%",
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),

              /// Projects Involved
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 6,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Icon(Icons.person, color: Colors.teal),
                    SizedBox(height: 12),
                    Text("Projects Involved",
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                    SizedBox(height: 8),
                    Text("Revenue\nDashboard",
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),

              /// Leave Taken
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 6,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Icon(Icons.event_note, color: Colors.teal),
                    SizedBox(height: 12),
                    Text("Leave Taken",
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                    SizedBox(height: 8),
                    Text("2 days",
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
