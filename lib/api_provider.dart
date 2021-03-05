import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sample_messanger/model.dart';

abstract class IApiProvider {
  Future<List<Conversation>> loadConversations(BuildContext context);

  void loadConversation(Conversation conversation);

  void subscribe(
    Conversation conversation,
    void Function(List<Message>) onConversationUpdated,
  );

  void sendMessageAndRespond(
    Conversation conversation,
    String message,
    BuildContext context,
  );

  void unsubscribe(Conversation conversation);
}

class ApiProvider implements IApiProvider {
  static final ApiProvider instance = ApiProvider._();

  final Map<Conversation, List<Message>> _content = {};
  final Map<Conversation, void Function(List<Message>)> _listeners = {};

  ApiProvider._();

  void Function(List<Conversation>) onConversationsUpdated;

  @override
  Future<List<Conversation>> loadConversations(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 200));
    final json = await DefaultAssetBundle.of(context)
        .loadString("assets/conversations.json");
    return List<Conversation>.from(
      jsonDecode(json).map((model) => Conversation.fromJson(model)),
    );
  }

  @override
  void loadConversation(Conversation conversation) async {
    await Future.delayed(Duration(milliseconds: 200));
    if (_listeners[conversation] != null) {
      _listeners[conversation](_content[conversation] ?? []);
    }
  }

  @override
  void subscribe(
    Conversation conversation,
    void Function(List<Message>) onConversationUpdated,
  ) {
    if (conversation != null) {
      _listeners.putIfAbsent(conversation, () => onConversationUpdated);
    }
  }

  @override
  void sendMessageAndRespond(
      Conversation conversation, String message, BuildContext context) async {
    _postMessage(conversation, Message(currentUser: message));
    await Future.delayed(Duration(seconds: 1));
    final response = await _loadOtherUserResponse(context);
    _postMessage(conversation, Message(otherUser: response));
  }

  @override
  void unsubscribe(Conversation conversation) {
    _listeners.removeWhere((key, value) => key == conversation);
  }

  void _postMessage(Conversation conversation, Message message) {
    if (_content.containsKey(conversation)) {
      _content[conversation].insert(0, message);
    } else {
      _content.putIfAbsent(conversation, () => [message]);
    }
    if (_listeners[conversation] != null) {
      _listeners[conversation](_content[conversation]);
    }
  }

  Future<String> _loadOtherUserResponse(BuildContext context) async {
    final json = jsonDecode(await DefaultAssetBundle.of(context)
        .loadString("assets/messages.json"));
    return json[Random().nextInt(json.length)];
  }
}
