import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ziya_user/constants/app_colors.dart';
import 'package:ziya_user/views/home/home_screen.dart';

class PunchOutSuccessPage extends StatefulWidget {
  const PunchOutSuccessPage({super.key});

  @override
  State<PunchOutSuccessPage> createState() => _PunchOutSuccessPageState();
}

class _PunchOutSuccessPageState extends State<PunchOutSuccessPage> {
  late String currentTime;

  @override
  void initState() {
    super.initState();
    currentTime = DateFormat('hh:mm a').format(DateTime.now());

    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
        (Route<dynamic> route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.white, Color.fromARGB(255, 255, 155, 61)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, size: 100, color: AppColors.orange),
              const SizedBox(height: 20),
              Text(
                'Punch out successfully\nat $currentTime',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  color: AppColors.orange,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
