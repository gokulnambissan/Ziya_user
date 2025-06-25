import 'package:flutter/material.dart';
import 'package:ziya_user/constants/app_colors.dart';
import 'package:ziya_user/views/on_site/scan_qr_code_page.dart';


class QrVerificationPage extends StatefulWidget {
  final bool isPunchOutFlow;
  final VoidCallback? onVerificationComplete;

  const QrVerificationPage({
    this.isPunchOutFlow = false,
    this.onVerificationComplete,
    Key? key,
  }) : super(key: key);

  @override
  _QrVerificationPageState createState() => _QrVerificationPageState();
}

class _QrVerificationPageState extends State<QrVerificationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.0, end: 120.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildQrContainer() {
    return SizedBox(
      width: 160,
      height: 160,
      child: Stack(
        children: [
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.white,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 6,
                  color: AppColors.black,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Image.asset(
              'assets/qr.png', // Replace with your QR icon path
              width: 100,
              height: 100,
              fit: BoxFit.contain,
            ),
          ),
          AnimatedBuilder(
            animation: _animation,
            builder: (_, __) {
              return Positioned(
                top: _animation.value,
                left: 20,
                right: 20,
                child: Container(
                  height: 2,
                  color: AppColors.priorityLow,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "QR Code Verification",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Please scan the QR code",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                _buildQrContainer(),
                const SizedBox(height: 60),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      final result = await Navigator.push<bool>(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ScanQrPage(
                            isPunchOutFlow: widget.isPunchOutFlow,
                            onQrScanned: widget.onVerificationComplete,
                          ),
                        ),
                      );

                      if (result == true) {
                        Navigator.pop(context, true);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Scan QR Code",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
