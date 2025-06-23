import 'package:flutter/material.dart';
import 'center_face_page.dart';

class FaceVerificationPage extends StatefulWidget {
  final bool isPunchOutFlow;
  final VoidCallback? onVerificationComplete;

  const FaceVerificationPage({
    this.isPunchOutFlow = false,
    this.onVerificationComplete,
    Key? key,
  }) : super(key: key);

  @override
  _FaceVerificationPageState createState() => _FaceVerificationPageState();
}

class _FaceVerificationPageState extends State<FaceVerificationPage>
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

  Widget _buildFaceContainer() {
    return SizedBox(
      width: 180,
      height: 180,
      child: Stack(
        children: [
          Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey.shade100,
              boxShadow: [
                const BoxShadow(
                  blurRadius: 4,
                  color: Colors.black12,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: const Icon(Icons.face_6_outlined, size: 80, color: Colors.black),
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
                  color: Colors.cyanAccent,
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Face Verification",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text("Please capture your face",
                  style: TextStyle(fontSize: 16, color: Colors.black54)),
              const SizedBox(height: 40),
              Center(child: _buildFaceContainer()),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push<bool>(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CenterFacePage(
                        isPunchOutFlow: widget.isPunchOutFlow,
                        onFaceCentered: widget.onVerificationComplete,
                      ),
                    ),
                  );

                  if (result == true) {
                    Navigator.pop(context, true);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Take Photo",
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
