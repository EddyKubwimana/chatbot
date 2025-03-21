import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'service/chat_provider.dart';
import 'screens/chat_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path/path.dart' as path;
import 'dart:io' show Platform;

void main() async {
  String envPath;
  if (kIsWeb) {
    envPath = path.join('assets', 'web', '.env');
  } else if (Platform.isAndroid) {
    envPath = path.join('assets', 'android', '.env');
  } else {
    envPath = path.join('assets', 'android', '.env');
  }
  // Load the .env file
  await dotenv.load(fileName: envPath);

  runApp(
    ChangeNotifierProvider(
      create: (context) => ChatProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ChatScreen(),
      ),
    ),
  );
}
