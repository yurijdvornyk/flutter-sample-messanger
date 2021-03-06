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
  final String name;
  final String username;
  final String avatar;
  final String? lastMessage;

  const Conversation(
    this.name,
    this.username,
    this.avatar, {
    this.lastMessage,
  });

  Conversation.fromJson(Map<String, dynamic> json)
      : this.name = json["name"],
        this.username = json["username"],
        this.avatar = json["avatar"],
        this.lastMessage = json["lastMessage"];

  Map<String, dynamic> toJson() => {
        "name": name,
        "username": username,
        "avatar": avatar,
        "lastMessage": lastMessage,
      };
}
