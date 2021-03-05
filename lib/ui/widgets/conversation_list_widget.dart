import 'package:flutter/material.dart';
import 'package:sample_messanger/model.dart';

class ConversationListWidget extends StatelessWidget {
  final List<Conversation>? conversations;
  final void Function(Conversation item) onItemSelected;

  const ConversationListWidget({
    Key? key,
    this.conversations,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => conversations == null
      ? Center(child: CircularProgressIndicator())
      : ListView.separated(
          itemCount: conversations?.length ?? 0,
          separatorBuilder: (context, position) => Container(
            height: 1.0,
            color: Colors.black,
          ),
          itemBuilder: (context, position) => ListTile(
            contentPadding: EdgeInsets.all(16.0),
            leading: ClipOval(
              clipBehavior: Clip.hardEdge,
              child: AspectRatio(
                  child: Image.asset(
                    "assets/images/${conversations![position].avatar}",
                  ),
                  aspectRatio: 1),
            ),
            title: Text(conversations![position].user),
            onTap: () => onItemSelected(conversations![position]),
          ),
        );
}
