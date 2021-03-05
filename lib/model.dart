class Message {
  final String? currentUser;
  final String? otherUser;

  Message({
    this.currentUser,
    this.otherUser,
  });

  Message.fromJson(Map<String, dynamic> json)
      : this.currentUser = json["currentUser"],
        this.otherUser = json["otherUser"];

  Map<String, dynamic> toJson() => {
        "currentUser": currentUser,
        "otherUser": otherUser,
      };
}

class Conversation {
  final String user;
  final String avatar;
  final String? lastMessage;

  const Conversation(
    this.user,
    this.avatar, {
    this.lastMessage,
  });

  Conversation.fromJson(Map<String, dynamic> json)
      : this.user = json["user"],
        this.avatar = json["avatar"],
        this.lastMessage = json["lastMessage"];

  Map<String, dynamic> toJson() => {
        "user": user,
        "avatar": avatar,
        "lastMessage": lastMessage,
      };
}
