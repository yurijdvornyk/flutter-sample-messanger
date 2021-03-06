import 'package:flutter/material.dart';
import 'package:sample_messanger/model.dart';

class ConversationListWidget extends StatefulWidget {
  final List<Conversation>? conversations;
  final void Function(Conversation item) onItemSelected;

  const ConversationListWidget({
    Key? key,
    this.conversations,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<ConversationListWidget> {
  Conversation? _selectedConversation;

  @override
  Widget build(BuildContext context) => widget.conversations == null
      ? Center(child: CircularProgressIndicator())
      : ListView.separated(
          itemCount: widget.conversations?.length ?? 0,
          itemBuilder: (context, position) =>
              buildConversationItem(widget.conversations![position]),
          separatorBuilder: (context, position) => buildSeparator(),
        );

  Widget buildConversationItem(Conversation conversation) => ListTile(
        contentPadding: EdgeInsets.all(16.0),
        leading: ClipOval(
          clipBehavior: Clip.hardEdge,
          child: AspectRatio(
              child: Image.asset("assets/images/${conversation.avatar}"),
              aspectRatio: 1),
        ),
        title: Text(conversation.name),
        subtitle: Text(conversation.username),
        selected: conversation == _selectedConversation,
        selectedTileColor: Theme.of(context).primaryColor,
        onTap: () => setState(() {
          _selectedConversation = conversation;
          widget.onItemSelected(_selectedConversation!);
        }),
      );

  Widget buildSeparator() => Container(
        height: 1.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-1.0, 0),
            end: Alignment(1.0, 0),
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).accentColor
            ],
          ),
        ),
      );
}
