import 'package:whatsapp_clone/common/enums/message_enum.dart';

class Message {
  final String senderId;
  final String receiverId;
  final String text;
  final MessageEnum messageType;
  final DateTime timeSent;
  final String messageId;
  final bool isSeen;
  
  Message({
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.messageType,
    required this.timeSent,
    required this.messageId,
    required this.isSeen,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'senderId': senderId});
    result.addAll({'receiverId': receiverId});
    result.addAll({'text': text});
    result.addAll({'messageType': messageType.type});
    result.addAll({'timeSent': timeSent.millisecondsSinceEpoch});
    result.addAll({'messageId': messageId});
    result.addAll({'isSeen': isSeen});
  
    return result;
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderId: map['senderId'] ?? '',
      receiverId: map['receiverId'] ?? '',
      text: map['text'] ?? '',
      messageType: (map['messageType'] as String).toEnum() ,
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
      messageId: map['messageId'] ?? '',
      isSeen: map['isSeen'] ?? false,
    );
  }
}
