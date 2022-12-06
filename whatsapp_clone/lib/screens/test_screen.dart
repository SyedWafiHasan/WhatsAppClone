import 'package:flutter/material.dart';
import 'package:whatsapp_clone/common/widgets/loader.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Loader(),
    );
  }
}