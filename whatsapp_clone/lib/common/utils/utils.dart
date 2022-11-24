import 'package:flutter/material.dart';
import 'package:whatsapp_clone/colors.dart';

void showSnackBar({required BuildContext context, required String content}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        content,
        style: const TextStyle(color: whiteColor),
      ),
      backgroundColor: appBarColor,
    ),
  );
}
