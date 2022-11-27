import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whatsapp_clone/colors.dart';

class UserInformationScreen extends StatelessWidget {
  static const String routeName = '/user-information';
  const UserInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Stack(
                children: const [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Icon(Icons.add_a_photo),
                  ),
                ],
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.add_a_photo)),
            ],
          ),
        ),
      ),
    );
  }
}
