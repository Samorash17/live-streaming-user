import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';
// import '../services/api_services.dart'; // Add your API service class here

class LivePage extends StatefulWidget {
  final String liveID;
  final bool isHost;

  const LivePage({
    Key? key,
    required this.liveID,
    this.isHost = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => LivePageState();
}

class LivePageState extends State<LivePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFadffff),
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
           children: [
          //   // Display the Live ID at the top of the page
          //   Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Text(
          //       'Live ID: ${widget.liveID}',
          //       style: const TextStyle(
          //         fontSize: 20,
          //         fontWeight: FontWeight.bold,
          //         color: Colors.deepOrange,
          //       ),
          //     ),
          //   ),
            // The live streaming UI (covers 2/3 of the page)
            Expanded(
              flex: 2,
              child: ZegoUIKitPrebuiltLiveStreaming(
                appID: 1955167483, // Input your AppID
                appSign: 'cb36b3e7fe056a6ba305ff08a3e4aba57f57d54dded50794d1cda8d91535745a', // Input your AppSign
                userID: 'localUserID',
                userName: 'user_localUserID',
                liveID: widget.liveID,
                config: (widget.isHost
                    ? ZegoUIKitPrebuiltLiveStreamingConfig.host()
                    : ZegoUIKitPrebuiltLiveStreamingConfig.audience()),
              ),
            ),
            // Button section (covers 1/3 of the page)
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // First row of buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildButton('Ambulance'),
                        _buildButton('Fire Brigade'),
                      ],
                    ),
                    const SizedBox(height: 16.0), // Spacing between rows
                    // Second row with a single button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildButton('Police'),
                        _buildButton('SHE Team'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to create buttons with neomorphic effect
  Widget _buildButton(String label) {
    return GestureDetector(
      
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF2B5B5),
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: const Offset(4, 4),
              blurRadius: 8,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Colors.white,
              offset: const Offset(-4, -4),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 32.0,
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: Color.fromARGB(255, 40, 27, 27),
          ),
        ),
      ),
    );
  }
}


