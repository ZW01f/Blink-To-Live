import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class MyDrawerController extends GetxController {}

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Drawer(
        backgroundColor: Color(0xff3E83FC),
        child: ListView(
          children: [
            ListTile(
              title: const Text(
                'Learn',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
            ListTile(
              title: const Text(
                'our book',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
            ListTile(
              title: const Text(
                'Contact',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
            ListTile(
              title: const Text(
                'language',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
            ListTile(
              title: const Text(
                'Dark mood',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
