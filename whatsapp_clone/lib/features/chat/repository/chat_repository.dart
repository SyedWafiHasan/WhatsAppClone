import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:whatsapp_clone/common/utils/utils.dart';
import 'package:whatsapp_clone/models/chat_contact.dart';
import 'package:whatsapp_clone/models/user_model.dart';

class ChatRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  ChatRepository({
    required this.firestore,
    required this.auth,
  });

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
  }) async {
    
  }

  void sendTextMessage({
    required BuildContext context,
    required String textMessage,
    required String receiverUserId,
    required UserModel senderUser,
  }) async {
    // users -> sender id -> receiver id -> messages
    // -> message id -> store message

    try {
      DateTime timeSent = DateTime.now();
      UserModel receiverUserData;

      DocumentSnapshot<Map<String, dynamic>> userDataMap =
          await firestore.collection('users').doc(receiverUserId).get();

      receiverUserData = UserModel.fromMap(userDataMap.data()!);

      // users -> receiver user id -> chats
      // -> current user id -> set data

      _saveDataToContactsSubcollection(
        senderUser,
        receiverUserData,
        textMessage,
        timeSent,
        receiverUserId,
      );

      _saveMessageToMessageSubcollection();
    } catch (e) {
      showSnackBar(
        context: context,
        content: e.toString(),
      );
    }
  }
}
