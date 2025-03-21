import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';
import '../models/chat_message.dart';
import 'dart:convert';

class ChatProvider extends ChangeNotifier {
  // history of chat  variable
  List<List<ChatMessage>> _chatHistory = [];
  int _currentChatIndex = 0;

  List<ChatMessage> get messages {
    if (_chatHistory.isEmpty || _currentChatIndex >= _chatHistory.length) {
      return [];
    }
    return _chatHistory[_currentChatIndex];
  }

  ChatProvider() {
    _loadChatHistory();
  }

  // Loading  history  of chat from SharedPreferences
  Future<void> _loadChatHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? chatHistory = prefs.getString('chatHistory');
    if (chatHistory != null) {
      List<dynamic> decodedChats = jsonDecode(chatHistory);
      _chatHistory = decodedChats.map((chat) {
        return (chat as List).map((msg) {
          return ChatMessage(text: msg['text'], isUser: msg['isUser']);
        }).toList();
      }).toList();
      notifyListeners();
    }

    if (_chatHistory.isEmpty) {
      _chatHistory.add([]);
    }
  }

  // Save chat history to SharedPreferences
  Future<void> _saveChatHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String chatHistory = jsonEncode(_chatHistory.map((chat) {
      return chat.map((msg) => msg.toJson()).toList();
    }).toList());
    prefs.setString('chatHistory', chatHistory);
  }

  // Send a message in the current chat
  Future<void> sendMessage(String userInput) async {
    if (userInput.isEmpty) return;

    if (_chatHistory.isEmpty || _currentChatIndex >= _chatHistory.length) {
      return;
    }

    _chatHistory[_currentChatIndex]
        .add(ChatMessage(text: userInput, isUser: true));
    notifyListeners();
    await _saveChatHistory();

    // API CALL
    String botResponse = await ApiService.getChatbotResponse(userInput);

    _chatHistory[_currentChatIndex]
        .add(ChatMessage(text: botResponse, isUser: false));
    notifyListeners();
    await _saveChatHistory();
  }

  // method to start a new chat
  void startNewChat() {
    _chatHistory.add([]);
    _currentChatIndex = _chatHistory.length - 1;
    notifyListeners();
  }

  void loadChat(int index) {
    if (index >= 0 && index < _chatHistory.length) {
      _currentChatIndex = index;
      notifyListeners();
    }
  }

  Future<void> clearChat() async {
    _chatHistory.clear();
    _currentChatIndex = 0;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('chatHistory');
  }

  List<List<ChatMessage>> get chatHistory => _chatHistory;
}
