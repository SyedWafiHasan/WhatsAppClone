import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:whatsapp_clone/colors.dart';
import 'package:whatsapp_clone/common/utils/utils.dart';
import 'package:whatsapp_clone/features/chat/controller/chat_controller.dart';

class BottomChatField extends ConsumerStatefulWidget {
  final String receiverUserId;
  const BottomChatField({
    Key? key,
    required this.receiverUserId,
  }) : super(key: key);

  @override
  ConsumerState<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends ConsumerState<BottomChatField> {
  bool showSendButton = false;
  final TextEditingController _messageController = TextEditingController();

  void sendTextMessage() async {
    if (showSendButton) {
      ref.read(chatControllerProvider).sendTextMessage(
            context,
            _messageController.text.trim(),
            widget.receiverUserId,
          );

      setState(() {
        _messageController.text = "";
      });
    }
  }

  void sendVoiceMessage() async {
    showSnackBar(
      context: context,
      content: "Voice message functionality has not been implemented yet.",
    );
  }

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextField(
              controller: _messageController,
              style: const TextStyle(
                fontSize: 20,
              ),
              onChanged: (value) {
                if (value.trim().isNotEmpty) {
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
            child: GestureDetector(
              onTap: sendTextMessage,
              onDoubleTap: sendVoiceMessage,
              child: Icon(
                showSendButton ? Icons.send : Icons.mic,
                color: whiteColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
