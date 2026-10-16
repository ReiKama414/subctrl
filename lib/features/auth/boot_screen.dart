import 'package:flutter/material.dart';
import 'package:subctrl/core/constants/app_info.dart';

/// Neutral gate while prefs / identities load. Latin-only so web never flashes tofu.
class BootScreen extends StatelessWidget {
  const BootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF0B0C0E),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppInfo.mark,
              style: TextStyle(
                color: Color(0xFF5EEAD4),
                fontSize: 28,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Color(0xFF5EEAD4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
