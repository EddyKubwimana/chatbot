import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  static Future<String> getChatbotResponse(String message) async {
    if (message.toLowerCase().contains("your name") ||
        message.toLowerCase().contains("who are you") ||
        message.toLowerCase().contains("ton nom") ||
        message.toLowerCase().contains("appele-tu") ||
        message.toLowerCase().contains("izina ryawe") ||
        message.toLowerCase().contains("witwa nde") ||
        message.toLowerCase().contains("amazina yawe")) {
      return "I am called Kankurize!";
    }

    if (!dotenv.isInitialized) {
      return "Error: dotenv not initialized!";
    }

    String apiKey = dotenv.env['GEMINI_API_KEY'] ?? "";
    if (apiKey.isEmpty) {
      return "Error: API Key is missing!";
    }

    String apiUrl =
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$apiKey";

    var response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {"text": message}
            ]
          }
        ]
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data["candidates"][0]["content"]["parts"][0]["text"];
    } else {
      return "Error: Unable to fetch response.";
    }
  }
}
