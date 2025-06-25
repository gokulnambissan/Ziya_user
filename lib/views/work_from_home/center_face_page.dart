import 'package:flutter/material.dart';
import 'package:ziya_user/constants/app_colors.dart';
import 'package:ziya_user/views/punch_out_success.dart';
import '../punch_in_success_page.dart';


class CenterFacePage extends StatelessWidget {
  final bool isPunchOutFlow;
  final VoidCallback? onFaceCentered;

  const CenterFacePage({
    this.isPunchOutFlow = false,
    this.onFaceCentered,
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
                        if (onFaceCentered != null) {
                          onFaceCentered!();
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
