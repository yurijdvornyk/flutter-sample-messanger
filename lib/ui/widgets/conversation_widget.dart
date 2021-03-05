import 'package:flutter/material.dart';
import 'package:sample_messanger/model.dart';

class ConversationWidget extends StatefulWidget {
  final Conversation conversation;
  final List<Message> messages;
  final void Function(String message) onMessageSend;

  const ConversationWidget(
    this.conversation,
    this.messages,
    this.onMessageSend, {
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<ConversationWidget> {
  static const ICON_SIZE = 128.0;

  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) => Column(children: [
        AppBar(
          title: Text(widget.conversation?.user ?? ""),
        ),
        Expanded(
            child: widget.conversation != null
                ? widget.messages != null
                    ? buildConversation()
                    : Center(child: CircularProgressIndicator())
                : buildNoConversationPlaceholder())
      ]);

  Widget buildNoConversationPlaceholder() => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: Container()),
          Icon(Icons.message, size: ICON_SIZE),
          SizedBox(height: 16.0),
          Text("Select conversation"),
          Expanded(child: Container()),
        ],
      );

  Widget buildConversation() => Column(children: [
        Expanded(
            child: widget.messages.isNotEmpty
                ? buildMessageList()
                : buildEmptyArea()),
        buildMessageForm(),
      ]);

  Widget buildEmptyArea() => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: Container()),
          Icon(
            Icons.campaign_rounded,
            size: ICON_SIZE,
          ),
          SizedBox(height: 16.0),
          Text('Start conversation by saying "Hello"!'),
          Expanded(child: Container()),
        ],
      );

  Widget buildMessageList() => ListView.separated(
        reverse: true,
        padding: EdgeInsets.all(16.0),
        itemCount: widget.messages.length,
        separatorBuilder: (BuildContext context, int position) =>
            Container(height: 16.0),
        itemBuilder: (BuildContext context, int position) {
          final message = widget.messages[position];
          final List<Widget> content = [];
          if (isMessageFromOtherUser(message)) {
            content.addAll([
              ClipOval(
                clipBehavior: Clip.hardEdge,
                child: Image.asset(
                  "assets/images/${widget.conversation.avatar}",
                  width: 32,
                  height: 32,
                ),
              ),
              SizedBox(width: 4)
            ]);
          }
          content.add(Expanded(flex: 4, child: createMessageBubble(message)));
          if (isMessageFromOtherUser(message)) {
            content.add(Expanded(flex: 1, child: Container()));
          } else {
            content.insert(0, Expanded(flex: 1, child: Container()));
          }
          return Row(
              mainAxisAlignment: message.otherUser != null
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: content);
        },
      );

  Widget createMessageBubble(Message message) {
    final radius = Radius.circular(16.0);
    return Container(
        decoration: BoxDecoration(
          borderRadius: isMessageFromOtherUser(message)
              ? BorderRadius.only(
                  topLeft: radius,
                  topRight: radius,
                  bottomRight: radius,
                )
              : BorderRadius.only(
                  topLeft: radius,
                  topRight: radius,
                  bottomLeft: radius,
                ),
          color: Colors.blueAccent,
        ),
        padding: EdgeInsets.all(16.0),
        child: Container(
          child: Text(
            message.currentUser ?? message.otherUser ?? "",
          ),
          width: 100,
        ));
  }

  Widget buildMessageForm() => Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: textController,
                textInputAction: TextInputAction.done,
                onEditingComplete: sendMessage,
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: sendMessage,
            )
          ],
        ),
      );

  void sendMessage() {
    widget.onMessageSend(textController.text);
    setState(() {
      textController.text = "";
    });
  }

  bool isMessageFromOtherUser(Message message) => message.otherUser != null;
}
