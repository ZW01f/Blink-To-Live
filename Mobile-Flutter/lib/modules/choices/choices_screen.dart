import 'package:flutter/material.dart';

import '../../shared/components/components.dart';
import '../dealing_with_model/dealing_with_model_screen.dart';
import '../teach_patient/teach_patient_screen.dart';

class ChoicesScreen extends StatelessWidget {
  const ChoicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ClipPath(
            clipper: CustomClipPath(),
            child: Container(
                height: 480,
                color: Color(0xff3E83FC),
                child: Center(
                    child: Padding(
                  padding: EdgeInsets.only(left: 70.0),
                  child: InkWell(
                    onTap: () {
                      navigateTo(context, TeachPatientScreen());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 25.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'IF',
                                  style: TextStyle(
                                      color: Color(0xffCFE0FE),
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'YOU NEED TO LEARN',
                                  style: TextStyle(
                                      color: Color(0xffCFE0FE),
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'CLICK HERE',
                                  style: TextStyle(
                                      color: Color(0xffCFE0FE),
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ]),
                    ),
                  ),
                ))),
          ),
          InkWell(
            onTap: () {
             navigateTo(context, DealingWithModelScreen());
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'IF',
                      style: TextStyle(
                          color: Color(0xffA8A8A8),
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'YOU NEED TO START',
                      style: TextStyle(
                          color: Color(0xffA8A8A8),
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'CLICK HERE',
                      style: TextStyle(
                          color: Color(0xffA8A8A8),
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double w = size.width;
    double h = size.height;
    path.lineTo(0, 120);
    path.quadraticBezierTo(w * 0.2, h - 50, w, h);
    path.lineTo(w, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
