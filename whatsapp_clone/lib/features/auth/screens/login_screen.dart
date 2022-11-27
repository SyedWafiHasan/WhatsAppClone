import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/colors.dart';
import 'package:whatsapp_clone/common/utils/utils.dart';
import 'package:whatsapp_clone/common/widgets/custom_button.dart';
import 'package:whatsapp_clone/features/auth/controller/auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = '/loginScreen';
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

//ConsumerStatefulWidgets enable access to refs
//Providers are used using Consumers

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final phoneController = TextEditingController();
  Country? country;

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  void pickCountry() {
    // ignore todo is here only to remove ErrorLens warning
    // this is still a valid todo
    // ignore: todo
    // TODO maybe find a better way to implement this
    // ignore: todo
    // TODO like perhaps with a different package

    showCountryPicker(
        context: context,
        onSelect: (Country _country) {
          setState(() {
            country = _country;
          });
        });
  }

  void sendPhoneNumber() {
    String phoneNumber = phoneController.text.trim();
    if (country != null && phoneNumber.isNotEmpty) {
      //ProviderRef is used to interact provider with provider
      //WidgetRef is used to make widget interact with provider
      String completePhoneNumber = '+${country!.phoneCode}$phoneNumber';
      ref.read(authControllerProvider).signInWithPhone(
            context,
            completePhoneNumber,
          );
    } else if (country == null) {
      showSnackBar(context: context, content: "Please select your country.");
    } else if (phoneNumber.isEmpty) {
      showSnackBar(context: context, content: "Please enter your phone number.");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter your phone number"),
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("WhatsApp will need to verify your phone number."),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: pickCountry,
                  child: const Text(
                    "Choose country",
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    if (country != null) Text('+${country!.phoneCode}'),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: size.width * 0.7,
                      child: TextField(
                        controller: phoneController,
                        decoration: const InputDecoration(
                          hintText: 'Phone Number',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "Carrier charges may apply.",
                    style: TextStyle(color: greyColor),
                  ),
                ),
              ],
            ),
            SizedBox(
              // width: size.width * 0.2,
              width: 90,
              child: CustomButton(
                onPressed: sendPhoneNumber,
                text: "Next",
              ),
            )
          ],
        ),
      ),
    );
  }
}
