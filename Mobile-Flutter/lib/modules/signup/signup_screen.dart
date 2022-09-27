import 'package:blink_to_live/modules/signup/cubit/Register_cubit.dart';
import 'package:blink_to_live/modules/signup/cubit/Register_states.dart';
import 'package:blink_to_live/modules/verification/verify_screen.dart';
import 'package:blink_to_live/shared/components/components.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class SignUpScreen extends StatelessWidget {
  TextEditingController phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  String countryCode = "+20";
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => SignUpCubit()..saveGoogleCurrentUer(),
      child: BlocConsumer<SignUpCubit, SignUpCubitStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = SignUpCubit.get(context);
            return Scaffold(
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30),
                  child: Center(
                    child: SafeArea(
                      child: Column(
                        children: [
                          Image(
                              image: AssetImage(
                                  'assets/Finally-without-shadow 2.png'),
                              width: 130,
                              height: 100),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Sign Up',
                            style: TextStyle(
                                fontSize: 22,
                                fontFamily: 'Segoe',
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 5,
                            color: Color(0xff3E83FC),
                          ),
                          SizedBox(height: 100),
                          Form(
                            key: formKey,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CountryCodePicker(
                                  enabled: true,
                                  initialSelection: 'EG',
                                  showCountryOnly: false,
                                  showOnlyCountryWhenClosed: false,
                                  onChanged: (v) {
                                    countryCode = v.toString();
                                  },
                                ),
                                Expanded(
                                    child: defaultTextFormField(
                                  hintText: 'Enter phone',
                                  controller: phoneController,
                                  validator: (String? value) =>
                                      validateMobile(value!),
                                )),
                              ],
                            ),
                          ),
                          SizedBox(height: 120),
                          InkWell(
                            child: state is SignUpLoadingCubitState
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : defaultAuthButton(
                                    buttonName: 'Sign Up',
                                  ),
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                String fullNumber =
                                    countryCode + phoneController.text;
                                cubit.signUpWithMobile(fullNumber, context);
                              }
                            },
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
                            padding: const EdgeInsets.only(
                                left: 30.0, right: 30, top: 10, bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: state
                                          is SignUpLoadingFacebookCubitState
                                      ? Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : socialMediaButton(
                                          asset: 'assets/facebook.png'),
                                  onTap: () async {
                                    cubit.signUpWithFaceBook(context);
                                  },
                                ),
                                SizedBox(
                                  width: 25,
                                ),
                                socialMediaButton(asset: 'assets/Tweter.png'),
                                SizedBox(
                                  width: 25,
                                ),
                                InkWell(
                                    child: state
                                            is SignUpGoogleLoadingCubitState
                                        ? Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : socialMediaButton(
                                            asset: 'assets/g+.png'),
                                onTap: (){
                                      cubit.signUpWithGoogle(context,);
                                },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid number';
    }
    return null;
  }
}
