import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsapp_clone/common/enums/message_enum.dart';
import 'package:whatsapp_clone/common/utils/utils.dart';
import 'package:whatsapp_clone/models/chat_contact.dart';
import 'package:whatsapp_clone/models/message.dart';
import 'package:whatsapp_clone/models/user_model.dart';

final chatRepositoryProvider = Provider(
  (ref) => ChatRepository(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
  ),
);

class ChatRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  ChatRepository({
    required this.firestore,
    required this.auth,
  });

  Stream<List<ChatContact>> getChatContact() {
    return firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .snapshots()
        .asyncMap((event) async {
      List<ChatContact> contacts = [];
      for (var document in event.docs) {
        ChatContact chatContact = ChatContact.fromMap(document.data());
        var userData = await firestore
            .collection('users')
            .doc(chatContact.contactId)
            .get();

        var user = UserModel.fromMap(userData.data()!);
        contacts.add(
          ChatContact(
            name: user.name,
            profilePicture: user.profilePic,
            contactId: chatContact.contactId,
            timeSent: chatContact.timeSent,
            lastMessage: chatContact.lastMessage,
          ),
        );
      }
      return contacts;
    });
  }

  void _saveDataToContactsSubcollection(
    UserModel senderUserData,
    UserModel receiverUserData,
    String textMessage,
    DateTime timeSent,
    String receiverUserId,
  ) async {
    // users -> receiver user id -> chats
    // -> current user id -> set data
    ChatContact receiverChatContact = ChatContact(
      name: senderUserData.name,
      profilePicture: senderUserData.profilePic,
      contactId: senderUserData.uid,
      timeSent: timeSent,
      lastMessage: textMessage,
    );

    await firestore
        .collection('users')
        .doc(receiverUserId)
        .collection('chats')
        .doc(senderUserData.uid)
        .set(
          receiverChatContact.toMap(),
        );

    // users -> current user id -> chats
    // -> receiver user id -> set data

    var senderChatContact = ChatContact(
      name: receiverUserData.name,
      profilePicture: receiverUserData.profilePic,
      contactId: senderUserData.uid,
      timeSent: timeSent,
      lastMessage: textMessage,
    );

    await firestore
        .collection('users')
        .doc(senderUserData.uid)
        .collection('chats')
        .doc(receiverUserId)
        .set(
          senderChatContact.toMap(),
        );
  }

  void _saveMessageToMessageSubcollection({
    required String receiverUserId,
    required String textMessage,
    required DateTime timeSent,
    required String messageId,
    required String senderUsername,
    required String receiverUsername,
    required MessageEnum messageType,
  }) async {
    final message = Message(
      senderId: auth.currentUser!.uid,
      receiverId: receiverUserId,
      text: textMessage,
      messageType: messageType,
      timeSent: timeSent,
      messageId: messageId,
      isSeen: false,
    );
    // users -> sender id -> receiver id -> messages
    // -> message id -> store message
    // but this needs to be done twice
    // once for sender, once for receiver

    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(receiverUserId)
        .collection('messages')
        .doc(messageId)
        .set(message.toMap());

    await firestore
        .collection('users')
        .doc(receiverUserId)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .collection('messages')
        .doc(messageId)
        .set(message.toMap());
  }

  void sendTextMessage({
    required BuildContext context,
    required String textMessage,
    required String receiverUserId,
    required UserModel senderUser,
  }) async {
    try {
      DateTime timeSent = DateTime.now();
      UserModel receiverUserData;

      DocumentSnapshot<Map<String, dynamic>> userDataMap =
          await firestore.collection('users').doc(receiverUserId).get();

      receiverUserData = UserModel.fromMap(userDataMap.data()!);

      var messageId = const Uuid().v1();

      // users -> receiver user id -> chats
      // -> current user id -> set data

      _saveDataToContactsSubcollection(
        senderUser,
        receiverUserData,
        textMessage,
        timeSent,
        receiverUserId,
      );

      _saveMessageToMessageSubcollection(
        receiverUserId: receiverUserId,
        textMessage: textMessage,
        timeSent: timeSent,
        messageType: MessageEnum.text,
        messageId: messageId,
        receiverUsername: receiverUserData.name,
        senderUsername: senderUser.name,
      );
    } catch (e) {
      showSnackBar(
        context: context,
        content: e.toString(),
      );
    }
  }
}
