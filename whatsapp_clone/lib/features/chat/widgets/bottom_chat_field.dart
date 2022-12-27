import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:whatsapp_clone/colors.dart';

class BottomChatField extends StatefulWidget {
  const BottomChatField({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends State<BottomChatField> {
  bool showSendButton = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextField(
              style: const TextStyle(fontSize: 20,),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    showSendButton = true;
                  });
                } else {
                  setState(() {
                    showSendButton = false;
                  });
                }
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: mobileChatBoxColor,
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.emoji_emotions,
                      color: Colors.grey,
                    ),
                  ),
                ),
                suffixIcon: SizedBox(
                  width: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.camera_alt,
                          color: Colors.grey,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.attach_file,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                hintText: "Type here",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                contentPadding: const EdgeInsets.all(10),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            right: 8,
            top: 5,
            bottom: 5,
          ),
          child: CircleAvatar(
            backgroundColor: const Color(0xFF128C7E),
            radius: 25,
            child: Icon(
              showSendButton ? Icons.send : Icons.mic,
              color: whiteColor,
            ),
          ),
        ),
      ],
    );
  }
}
