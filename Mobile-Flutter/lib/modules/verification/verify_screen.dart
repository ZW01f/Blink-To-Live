import 'package:blink_to_live/modules/signin/signin_screen.dart';
import 'package:blink_to_live/shared/components/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../choices/choices_screen.dart';
class VerifyScreen extends StatelessWidget {

  VerifyScreen({required this.verificationId,required this.resendToken,required this.phoneNumber});
String verificationId;
 int resendToken;
 String phoneNumber;
 String ?optc;
FirebaseAuth auth=FirebaseAuth.instance;
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
              ), SizedBox(
                height: 20,
              ),
              Text(
                'Enter the 4 digit pin that we sent to :',
                style: TextStyle(fontFamily: 'Segoe', fontSize: 19),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                '$phoneNumber',
                style: TextStyle(fontFamily: 'Segoe', fontSize: 19,fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 25,
              ),
              PinCodeTextField(
                enablePinAutofill: true,
                length: 6,
                obscureText: false,
                hintCharacter: '*',
                keyboardType: TextInputType.phone,
                hintStyle: TextStyle(fontSize: 25.0,),
                pinTheme: PinTheme(
                  inactiveColor: Colors.grey,
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(10.0),
                  fieldHeight: 50,
                  fieldWidth: 45,
                  activeFillColor: Colors.white,
                ), onChanged:(value){
                       optc=value;
                       print(optc);
              }, appContext:context,

              ),
              GestureDetector(
                  child: Text(
                    'Resend Code',
                    style: TextStyle(
                        color: Color(0xff3E83FC),
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                  }),
            SizedBox(height: 100.0,),
              InkWell(child: defaultAuthButton(buttonName: 'Verify',),onTap: ()async{
                PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: optc!);
                await auth.signInWithCredential(credential);
                if(auth.currentUser!=null){
                  navigateTo(context,ChoicesScreen());
                  }
              },)
            ],
          ),
        ),
      ),
    );
  }
}
