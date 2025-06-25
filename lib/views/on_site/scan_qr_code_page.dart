import 'package:flutter/material.dart';
import 'package:ziya_user/views/punch_out_success.dart';
import '../punch_in_success_page.dart';
import 'package:ziya_user/constants/app_colors.dart';

class ScanQrPage extends StatelessWidget {
  final bool isPunchOutFlow;
  final VoidCallback? onQrScanned;

  const ScanQrPage({
    this.isPunchOutFlow = false,
    this.onQrScanned,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  SizedBox(height: 24),
                  Text(
                    "Scan QR Code",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Align the QR code inside the box\nto scan it successfully",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.qr_code_scanner, size: 32),
                  const SizedBox(width: 40),
                  GestureDetector(
                    onTap: () async {
                      final result = await Navigator.push<bool>(
                        context,
                        MaterialPageRoute(
                          builder: (_) => isPunchOutFlow
                              ? const PunchOutSuccessPage()
                              : const SuccessPage(),
                        ),
                      );

                      if (result == true) {
                        Navigator.pop(context, true); // return to previous page
                        if (onQrScanned != null) {
                          onQrScanned!();
                        }
                      }
                    },
                    child: const CircleAvatar(
                      backgroundColor: AppColors.blue,
                      radius: 32,
                      child: Icon(Icons.check, size: 32, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 40),
                  const Icon(Icons.lightbulb, size: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
