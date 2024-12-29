import 'package:flutter/material.dart';
import 'screens/broadcast_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade50,
              Colors.white,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.emergency_share_rounded,
                size: 80,
                color: Colors.blue,
              ),
              const SizedBox(height: 24),
              const Text(
                'Your quick action can save lives.',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Text(
                'Start streaming now to alert and assist.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              _buildAnimatedStreamButton(context),
              const Spacer(),
              const Text(
                'Over 445,000 cases were reported last year.\nYour stream can make a difference.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedStreamButton(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 1.0, end: 1.1),
      duration: const Duration(seconds: 2),
      builder: (context, double scale, child) {
        return Transform.scale(
          scale: scale,
          child: child,
        );
      },
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const BroadcastScreen(
                streamKey: 'your-stream-key',
                streamProfile: '720p',
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        icon: const Icon(Icons.live_tv),
        label: const Text(
          'START STREAM',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
