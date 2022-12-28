class ChatContact {
  final String name;
  final String profilePicture;
  final String contactId;
  final DateTime timeSent;
  final String lastMessage;
  
  ChatContact({
    required this.name,
    required this.profilePicture,
    required this.contactId,
    required this.timeSent,
    required this.lastMessage,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'name': name});
    result.addAll({'profilePicture': profilePicture});
    result.addAll({'contactId': contactId});
    result.addAll({'timeSent': timeSent.millisecondsSinceEpoch});
    result.addAll({'lastMessage': lastMessage});
  
    return result;
  }

  factory ChatContact.fromMap(Map<String, dynamic> map) {
    return ChatContact(
      name: map['name'] ?? '',
      profilePicture: map['profilePicture'] ?? '',
      contactId: map['contactId'] ?? '',
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
      lastMessage: map['lastMessage'] ?? '',
    );
  }
}
