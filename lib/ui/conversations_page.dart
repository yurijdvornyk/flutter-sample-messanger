import 'package:flutter/material.dart';
import 'package:sample_messanger/api_provider.dart';
import 'package:sample_messanger/ui/chat_page.dart';
import 'package:sample_messanger/model.dart';
import 'package:sample_messanger/ui/widgets/conversation_list_widget.dart';
import 'package:sample_messanger/ui/widgets/conversation_widget.dart';

import 'adaptive_page_state.dart';

class ConversationsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends AdaptivePageState<ConversationsPage> {
  List<Conversation>? conversations;

  Conversation? selectedConversation;
  List<Message>? conversationMessages;

  @override
  void initState() {
    super.initState();
    apiProvider.loadConversations(context).then((entries) {
      setState(() {
        conversations = entries;
      });
    });
  }

  @override
  void dispose() {
    if (selectedConversation != null) {
      apiProvider.unsubscribe(selectedConversation);
    }
    super.dispose();
  }

  @override
  Widget buildPhoneState(BuildContext context) => Scaffold(
        body: SafeArea(
          child: ConversationListWidget(
            conversations: conversations,
            onItemSelected: (item) => openConversationScreen(item),
          ),
        ),
      );

  @override
  Widget buildTabletState(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: ConversationListWidget(
                  conversations: conversations,
                  onItemSelected: (item) => onConversationSelected(item),
                ),
              ),
              Expanded(
                flex: 3,
                child: ConversationWidget(
                  selectedConversation,
                  conversationMessages,
                  (message) {
                    apiProvider.sendMessageAndRespond(
                      selectedConversation!,
                      message,
                      context,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );

  @override
  Widget buildDesktopState(BuildContext context) => buildTabletState(context);

  @override
  Widget buildWebState(BuildContext context) => buildTabletState(context);

  void onConversationSelected(Conversation conversation) {
    setState(() {
      if (conversation != selectedConversation) {
        if (selectedConversation != null) {
          apiProvider.unsubscribe(selectedConversation);
        }
        selectedConversation = conversation;
        apiProvider.subscribe(selectedConversation!, (messages) {
          setState(() {
            conversationMessages = messages;
          });
        });
        conversationMessages = null;
      }
      apiProvider.loadConversation(selectedConversation!);
    });
  }

  void openConversationScreen(Conversation conversation) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatPage(conversation),
        ),
      );
}
