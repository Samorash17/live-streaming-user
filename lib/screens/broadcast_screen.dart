import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BroadcastScreen extends StatefulWidget {
  final String streamKey;
  final String streamProfile;

  const BroadcastScreen({
    super.key,
    required this.streamKey,
    required this.streamProfile,
  });

  @override
  State<BroadcastScreen> createState() => _BroadcastScreenState();
}

class _BroadcastScreenState extends State<BroadcastScreen> {
  final StreamService _streamService = StreamService();
  MediaStream? _localStream;
  final _localRenderer = RTCVideoRenderer();
  bool _isStreaming = false;
  String _status = '';
  String? _streamId;

  @override
  void initState() {
    super.initState();
    _initializeStream();
  }

  Future<void> _initializeStream() async {
    await _localRenderer.initialize();
    await _checkPermissions();
    await _getUserMedia();
  }

  Future<void> _checkPermissions() async {
    await Permission.camera.request();
    await Permission.microphone.request();
  }

  Future<void> _getUserMedia() async {
    final Map<String, dynamic> constraints = {
      'audio': true,
      'video': {
        'facingMode': 'environment',
        'mirror': false,
        ...getVideoConstraints(widget.streamProfile),
      }
    };

    try {
      final stream = await navigator.mediaDevices.getUserMedia(constraints);
      setState(() {
        _localStream = stream;
        _localRenderer.srcObject = stream;
      });
    } catch (e) {
      setState(() => _status = 'Error getting user media: $e');
    }
  }

  Map<String, dynamic> getVideoConstraints(String profile) {
    switch (profile) {
      case '1080p':
        return {
          'width': {'ideal': 1920},
          'height': {'ideal': 1080},
        };
      case '720p':
        return {
          'width': {'ideal': 1280},
          'height': {'ideal': 720},
        };
      case '540p':
        return {
          'width': {'ideal': 960},
          'height': {'ideal': 540},
        };
      default:
        return {
          'width': {'ideal': 640},
          'height': {'ideal': 360},
        };
    }
  }

  Future<void> _toggleStreaming() async {
    if (!_isStreaming) {
      try {
        final streamResponse = await _streamService.createStream();
        _streamId = streamResponse['id'] as String;
        final rtmpUrl =
            'rtmp://global-live.mux.com:5222/app/${widget.streamKey}';
        setState(() {
          _isStreaming = true;
          _status = 'Streaming... ID: $_streamId';
        });
      } catch (e) {
        setState(() => _status = 'Error: $e');
      }
    } else {
      try {
        if (_streamId != null) {
          await _streamService.deleteStream(_streamId!);
        }
        setState(() {
          _isStreaming = false;
          _status = 'Stream stopped';
          _streamId = null;
        });
      } catch (e) {
        setState(() => _status = 'Error stopping stream: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Broadcast'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _localStream != null
                ? RTCVideoView(
                    _localRenderer,
                    mirror: false,
                    objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(_status),
                ElevatedButton(
                  onPressed: _localStream != null ? _toggleStreaming : null,
                  child: Text(_isStreaming ? 'Stop Stream' : 'Start Stream'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _localStream?.dispose();
    super.dispose();
  }
}

///api service

class StreamService {
  final String baseUrl;

  StreamService({this.baseUrl = 'http://192.168.209.22:3000'});

  Future<Map<String, dynamic>> createStream() async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/streams'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'title': 'Emergency Stream',
        'description': 'Live emergency broadcast',
        'status': 'idle'
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to create stream');
    }
  }

  Future<void> updateStreamStatus(String streamId, String status) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/api/streams/$streamId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'status': status}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update stream status');
    }
  }

  Future<void> deleteStream(String streamId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/api/streams/$streamId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete stream');
    }
  }
}
