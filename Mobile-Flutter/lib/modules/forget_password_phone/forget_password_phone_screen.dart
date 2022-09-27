import 'package:blink_to_live/modules/forget_password_email/forget_password_email_screen.dart';
import 'package:blink_to_live/shared/components/components.dart';
import 'package:flutter/material.dart';

class ForgetPasswordPhoneScreen extends StatelessWidget {
  const ForgetPasswordPhoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.blue),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 38.0, right: 38),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                  image: AssetImage('assets/Finally-without-shadow 2.png'),
                  width: 110,
                  height: 80),
              SizedBox(height: 15),
              Text(
                'Verify Your Account',
                style: TextStyle(
                    fontFamily: 'Segoe',
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'To get a verification code, first confirm the recovery phone number that you added to your account',
                style: TextStyle(fontFamily: 'Segoe', fontSize: 19),
              ),
              SizedBox(
                height: 25,
              ),
              defaultTextFormField(hintText: 'phone number'),
              GestureDetector(
                child: Text(
                  'Try another way',
                  style: TextStyle(
                      fontFamily: 'Segoe',
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                onTap: () {
                  navigateTo(context, ForgetPasswordEmailScreen());
                },
              ),
              SizedBox(
                height: 30,
              ),
              defaultAuthButton(buttonName: 'Next'),
            ],
          ),
        ),
      ),
    );
  }
}
