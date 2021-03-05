import 'package:flutter/material.dart';
import 'package:sample_messanger/api_provider.dart';
import 'package:sample_messanger/ui/base_page_state.dart';
import 'package:sample_messanger/model.dart';
import 'package:sample_messanger/ui/widgets/conversation_widget.dart';

class ChatPage extends StatefulWidget {
  final Conversation conversation;

  ChatPage(this.conversation);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends BasePageState<ChatPage> {
  final apiProvider = ApiProvider.instance;

  List<Message> conversationMessages;

  @override
  void initState() {
    super.initState();
    apiProvider.subscribe(widget.conversation, (messages) {
      setState(() {
        conversationMessages = messages;
      });
    });
    apiProvider.loadConversation(widget.conversation);
  }

  @override
  buildPhoneState(BuildContext context) => Scaffold(
        body: SafeArea(
          child: ConversationWidget(
            widget.conversation,
            conversationMessages,
            (message) {
              apiProvider.sendMessageAndRespond(
                widget.conversation,
                message,
                context,
              );
            },
          ),
        ),
      );

  @override
  void dispose() {
    apiProvider.unsubscribe(widget.conversation);
    super.dispose();
  }
}
