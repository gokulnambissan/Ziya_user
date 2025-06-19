import 'package:flutter/material.dart';

class OngoingPendingPage extends StatelessWidget {
  const OngoingPendingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // --- Task 1 ---
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("UI/UX Design Implementation",
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    Text("80% Done",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 12),
                Row(children: const [
                  Text("Status: "),
                  Text("Ongoing Task",
                      style:
                          TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                ]),
                SizedBox(height: 6),
                Text("Assigned date: 12-05-2025"),
                Text("Due date: 12-06-2025"),
                SizedBox(height: 6),
                Row(children: const [
                  Text("Priority "),
                  Text("High",
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                ]),
                SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    child: Text("Make as Done"),
                  ),
                ),
              ],
            ),
          ),

          buildDottedDivider(),

          // --- Task 2 ---
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Responsive Design",
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    Text("45% Done",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 12),
                Row(children: const [
                  Text("Status: "),
                  Text("Pending Task",
                      style:
                          TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                ]),
                SizedBox(height: 6),
                Text("Assigned date: 12-05-2025"),
                Text("Due date: 12-06-2025"),
                SizedBox(height: 6),
                Row(children: const [
                  Text("Priority "),
                  Text("Medium",
                      style:
                          TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                ]),
                SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    child: Text("Start task"),
                  ),
                ),
              ],
            ),
          ),

          buildDottedDivider(),

          // --- Task 3 ---
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Back-end Development",
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    Text("75% Done",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 12),
                Row(children: const [
                  Text("Status: "),
                  Text("Ongoing Task",
                      style:
                          TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                ]),
                SizedBox(height: 6),
                Text("Assigned date: 12-05-2025"),
                Text("Due date: 12-06-2025"),
                SizedBox(height: 6),
                Row(children: const [
                  Text("Priority "),
                  Text("High",
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                ]),
                SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    child: Text("Mark as Done"),
                  ),
                ),
              ],
            ),
          ),

          buildDottedDivider(),

          // --- Task 4 ---
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Server-side Logic",
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    Text("75% Done",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 12),
                Row(children: const [
                  Text("Status: "),
                  Text("Pending Task",
                      style:
                          TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                ]),
                SizedBox(height: 6),
                Text("Assigned date: 12-05-2025"),
                Text("Due date: 12-06-2025"),
                SizedBox(height: 6),
                Row(children: const [
                  Text("Priority "),
                  Text("Low",
                      style: TextStyle(
                          color: Colors.cyanAccent,
                          fontWeight: FontWeight.bold)),
                ]),
                SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    child: Text("Mark as Done"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Dotted Divider
  Widget buildDottedDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: LayoutBuilder(
        builder: (context, constraints) {
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
        },
      ),
    );
  }
}
