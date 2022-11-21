import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/colors.dart';
import 'package:whatsapp_clone/common/widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/loginScreen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                          hintText: 'phone number',
                        ),
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
                onPressed: () {},
                text: "Next",
              ),
            )
          ],
        ),
      ),
    );
  }
}
