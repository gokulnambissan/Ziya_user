import 'package:flutter/material.dart';
import 'success_page.dart';

class CenterFacePage extends StatelessWidget {
  const CenterFacePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: SafeArea(
        child: Stack(
          children: [
            // Centered instruction text
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.play_circle_outline, size: 80, color: Colors.grey),
                  SizedBox(height: 24),
                  Text(
                    "Center your face",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Point your face right at the box,\nthen take a photo",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),

            // Bottom camera/flash/check buttons
            Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.camera_alt, size: 32),
                  const SizedBox(width: 40),
                  GestureDetector(
                    onTap: () async {
                      // Step 1: Navigate to success page
                      final result = await Navigator.push<bool>(
                        context,
                        MaterialPageRoute(builder: (_) => const SuccessPage()),
                      );

                      // Step 2: Pass result back to previous screen
                      Navigator.pop(context, result ?? false);
                    },
                    child: const CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 32,
                      child: Icon(Icons.check, size: 32, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 40),
                  const Icon(Icons.flash_on, size: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
