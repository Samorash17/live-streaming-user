import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('How to Use'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoStep(
              '1. Sign In or Register',
              'Log in with your credentials or create an account using your phone number or email.',
              Icons.login,
            ),
            _buildInfoStep(
              '2. Enable Location Services',
              'Allow the app to access your location for precise tracking and emergency reporting.',
              Icons.location_on,
            ),
            _buildInfoStep(
              '3. Initiate a Live Stream',
              'Tap the "Alert" button to begin broadcasting live video and sharing your location with nearby emergency services.',
              Icons.videocam,
            ),
            _buildInfoStep(
              '4. Choose Incident Type',
              'Select the type of emergency (e.g., police, fire bridge, or ambulance) to notify relevant authorities.',
              Icons.category,
            ),
            _buildInfoStep(
              '5. Monitor Real-Time Assistance',
              'Your live stream will be directed to nearby police stations, hospitals, or response teams. Authorities can assess the situation and respond promptly.',
              Icons.monitor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoStep(String title, String description, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 24, color: Colors.blue),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 