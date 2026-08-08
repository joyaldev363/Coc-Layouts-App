import 'package:flutter/material.dart';

class LegalPage extends StatelessWidget {
  final String title;

  const LegalPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117), // Dark theme
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D1117),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (Navigator.canPop(context)) Navigator.pop(context);
          },
        ),
        title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Text(
          _getDummyText(title),
          style: const TextStyle(color: Colors.white70, fontSize: 14, height: 1.6),
        ),
      ),
    );
  }

  String _getDummyText(String title) {
    return 'Welcome to the $title for Clash Layouts.\n\n'
        '1. Introduction\n'
        'This is a placeholder text for the $title. In a real application, you would include all the necessary legal jargon, user rights, data collection policies, and terms of use here.\n\n'
        '2. Data Collection\n'
        'We do not collect any personal information without your explicit consent. Any data gathered is strictly used for improving the app experience.\n\n'
        '3. User Responsibilities\n'
        'By using this app, you agree to not misuse the provided layouts and to respect the community guidelines.\n\n'
        '4. Updates\n'
        'These terms may be updated from time to time. You will be notified of any significant changes.\n\n'
        '5. Contact Us\n'
        'If you have any questions regarding this $title, please contact support@clashlayouts.com.';
  }
}
