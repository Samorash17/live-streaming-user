// Dart imports:
import 'dart:math' as math;
import 'package:flutter/material.dart'; // Add this import

/// Note that the userID needs to be globally unique,
final String localUserID = '1234';
// This generates a random user ID when app starts
// This generates a random live stream ID
final liveTextCtrl =
    TextEditingController(text: math.Random().nextInt(10000).toString());
const String zegoServerUrl =
    "wss://webliveroom1955167483-api.coolzcloud.com/ws";
