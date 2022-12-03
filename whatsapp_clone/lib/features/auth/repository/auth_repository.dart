import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/utils/utils.dart';
import 'package:whatsapp_clone/features/auth/screens/otp_screen.dart';
import 'package:whatsapp_clone/features/auth/screens/user_information_screen.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    firebaseAuth: FirebaseAuth.instance,
    firebaseFirestore: FirebaseFirestore.instance,
  ),
);

class AuthRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  AuthRepository({
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });

  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      await firebaseAuth.verifyPhoneNumber(
        verificationCompleted: (PhoneAuthCredential credential) async {
          await firebaseAuth.signInWithCredential(credential);
        },
        verificationFailed: (error) {
          throw Exception(error.message);
        },
        codeSent: ((String verificationId, int? resentToken) async {
          Navigator.pushNamed(
            context,
            OTPScreen.routeName,
            arguments: verificationId,
          );
        }),
        codeAutoRetrievalTimeout: (String verificationId) {},
        phoneNumber: phoneNumber,
      );
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  void verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String userOTP,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOTP,
      );
      await firebaseAuth.signInWithCredential(credential);
      Navigator.pushNamedAndRemoveUntil(
        context,
        UserInformationScreen.routeName,
        (route) => false,
      );
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  void saveUserDataToFirebase({
    required String name,
    required File? profilePic,
    required ProviderRef ref,
    required BuildContext context,
  }) async {
    try {
      String uid = firebaseAuth.currentUser!.uid;
      String? photoUrl = null;
      if(profilePic != null) {

      }
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
