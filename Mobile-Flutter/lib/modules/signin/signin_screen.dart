import 'package:blink_to_live/modules/forget_password_email/forget_password_email_screen.dart';
import 'package:blink_to_live/modules/signup/signup_screen.dart';
import 'package:blink_to_live/shared/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 38.0, right: 38),
            child: SafeArea(
              child: Column(
                children: [
                  Image(
                      image:
                          AssetImage('assets/Finally-without-shadow 2.png'),
                      width: 130,
                      height: 100),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'Segoe',
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Container(
                    height: 5,
                    color: Color(0xff3E83FC),
                  ),
                  SizedBox(height: 50),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'username',
                        style: TextStyle(
                            fontFamily: 'Segoe',
                            fontSize: 18,
                            color: Color(0xff707070)),
                      ),
                      defaultTextFormField(
                          hintText: 'name@email.com', icon: Icons.person_outline),
                      SizedBox(height: 10),
                      Text(
                        'password',
                        style: TextStyle(
                            fontFamily: 'Segoe',
                            fontSize: 18,
                            color: Color(0xff707070)),
                      ),
                      defaultTextFormField(
                          hintText: 'enter your password',
                          icon: CupertinoIcons.eye),
                      SizedBox(height: 15),
                      defaultAuthButton(buttonName: 'Login'),
                      SizedBox(height: 5),
                      GestureDetector(
                          onTap: () {
                            navigateTo(context, ForgetPasswordEmailScreen());
                          },
                          child: Text(
                            'Forget password?',
                            style: TextStyle(color: Color(0xff3E83FC)),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            'Don\'t have account?  ',
                            style: TextStyle(
                                color: Color(0xff3E83FC),
                                fontFamily: 'Segoe',
                                fontSize: 16),
                          ),
                          GestureDetector(
                              child: Text(
                                'SignUp',
                                style: TextStyle(
                                    color: Color(0xff3E83FC),
                                    fontFamily: 'Segoe',
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                              onTap: () {
                                navigateTo(context,SignUpScreen());
                              })
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        color: Color(0xff70707042),
                        height: 1,
                      ),
                      SizedBox(
                        height: 45,
                      ),
                      Center(
                          child: Text(
                        'Connect With Social Media',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Segoe',
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      )),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.only(left: 30.0, right: 30, top: 10 , bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            socialMediaButton(asset: 'assets/facebook.png'),
                            SizedBox(width: 25,),
                            socialMediaButton(asset: 'assets/Tweter.png'),
                            SizedBox(width: 25,),
                            socialMediaButton(asset: 'assets/g+.png'),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
