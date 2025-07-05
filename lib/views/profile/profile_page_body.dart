import 'package:flutter/material.dart';
import 'package:ziya_user/constants/app_colors.dart';
import 'package:ziya_user/views/home/home_screen.dart';

class ProfilePageBody extends StatelessWidget {
  const ProfilePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ── Banner with profile ──
            Stack(
              clipBehavior: Clip.none,
              children: [
                SizedBox(
                  height: 180,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/banner.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: -40,
                  left: 20,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: const AssetImage('assets/profile_pic.jpg'),
                    backgroundColor: Colors.white,
                  ),
                ),
                const Positioned(
                  bottom: 20,
                  left: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hemant Rangarajan',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.blue,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Full-stack Developer',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),

            // ── Info Card ──
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _InfoRow(label: 'Name', value: 'Hemant Rangarajan'),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: DottedLine(color: AppColors.lightGrey),
                  ),
                  SizedBox(height: 10),
                  _InfoRow(label: 'Employee ID', value: 'EMP00123'),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: DottedLine(color: AppColors.lightGrey),
                  ),
                  SizedBox(height: 10),
                  _InfoRow(label: 'Designation', value: 'Full-Stack Developer'),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: DottedLine(color: AppColors.lightGrey),
                  ),
                  SizedBox(height: 10),
                  _InfoRow(
                    label: 'Department',
                    value: 'Software Development Team',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                );
              },
              child: Image.asset(
                'assets/work_illu.png',
                height: 250,
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          const Text(':    '),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.lightGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DottedLine extends StatelessWidget {
  final double height;
  final Color color;
  final double dotWidth;
  final double space;

  const DottedLine({
    this.height = 1,
    this.color = Colors.grey,
    this.dotWidth = 4,
    this.space = 4,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxWidth = constraints.constrainWidth();
        final dotCount = (boxWidth / (dotWidth + space)).floor();

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dotCount, (_) {
            return Container(
              width: dotWidth,
              height: height,
              color: color,
            );
          }),
        );
      },
    );
  }
}
