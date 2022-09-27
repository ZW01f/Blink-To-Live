// ignore_for_file: must_be_immutable
import 'dart:async';
import 'dart:convert';
import 'package:blink_to_live/modules/drawer/view.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../main.dart';

class DealingWithModelScreen extends StatefulWidget {
 
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<DealingWithModelScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isWorking = false;
  String result = '';
  CameraController? cameraController;
  CameraImage? cameraImage;
  var ourImageArray;
  var parsedJson;
  var bytes;
 WebSocketChannel channel = IOWebSocketChannel.connect(
      "ws://ec2-18-220-177-248.us-east-2.compute.amazonaws.com:8080/blink-to-live"
      // "ws://192.168.88.91:8080/ws",
      );
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  initCamera() {
    cameraController = CameraController(cameras![1], ResolutionPreset.medium,
        imageFormatGroup: ImageFormatGroup.jpeg);
    cameraController!.initialize().then((value) {
      if (!mounted) {
        return;
      }
      cameraController!.startImageStream((CameraImage img) {
        Timer timer = Timer.periodic(const Duration(seconds: 3), (timer) {
          setState(() {
            cameraImage = img;
            ourImageArray = img.planes[0].bytes;
            channel.sink.add(ourImageArray);
          });
        });
      });
    });
  }

  String getFaceMove(AsyncSnapshot<dynamic> snapshot) {
    return snapshot.hasData ? '${jsonDecode(snapshot.data)["faces"]}' : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 180.0),
                  child: Center(
                      child: Text(
                    'What the patient say show here',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )),
                ),
                color: Color(0xff3E83FC),
                height: 550,
                width: double.infinity,
              ),
              cameraImage == null
                  ? ClipPath(
                      clipper: CustomClipPath(),
                      child: Container(
                        color: Colors.red,
                        height: 270,
                        width: double.infinity,
                        child: Image(
                          image: AssetImage(
                            'assets/patient.jpg',
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    )
                  : ClipPath(
                      clipper: CustomClipPath(),
                      child: AspectRatio(
                        aspectRatio: cameraController!.value.aspectRatio,
                        child: CameraPreview(cameraController!),
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 18),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                      onPressed: () {
                        _scaffoldKey.currentState!.openDrawer();
                      },
                      icon: Icon(Icons.menu, color: Colors.white, size: 25)),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 20,
              ),
              Text(
                'Movements',
                style: TextStyle(
                    color: Color(0xff959595),
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          // TextButton(
          //     onPressed: () {
          //       widget.channel.sink.close();
          //     },
          //     child: Text('Stop')),
          StreamBuilder(
            stream: channel.stream,
            builder: (context, snapshot) {
              print(
                  "##############################${snapshot.data.toString()}############################");
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  getFaceMove(snapshot),
                  style: const TextStyle(color: Colors.black),
                ),
              );
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          initCamera();
        },
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Color(0xff3E83FC),
        child: Icon(
          CupertinoIcons.video_camera,
          size: 30,
        ),
      ),
      drawer: SizedBox(
        width: 250,
        child: Drawer(
          backgroundColor: Color(0xff3E83FC),
          child: ListView(
            children: [
              SizedBox(
                height: 30,
              ),
              ListTile(
                title: const Text(
                  'Learn',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
                onTap: () {
                  navigator!.pop(context);
                },
              ),
              SizedBox(height: 15),
              ListTile(
                title: const Text(
                  'Our Book',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
                onTap: () {
                  navigator!.pop(context);
                },
              ),
              SizedBox(height: 15),
              ListTile(
                title: const Text(
                  'Language',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
                onTap: () {
                  navigator!.pop(context);
                },
              ),
              SizedBox(height: 15),
              ListTile(
                title: const Text(
                  'Contact',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
                onTap: () {
                  navigator!.pop(context);
                },
              ),
              SizedBox(height: 15),
              ListTile(
                title: const Text(
                  'Dark Mood  ',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
                onTap: () {
                  navigator!.pop(context);
                },
              ),
              SizedBox(
                height: 270,
              ),
              Container(
                color: Colors.white,
                height: 70,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.person,
                          color: Colors.grey,
                        )),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'youssef gamal',
                          style: TextStyle(
                              color: Color(0xff496173),
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Egypt',
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.exit_to_app,
                          color: Colors.blue,
                          size: 18,
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
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
    path.lineTo(0, 200);
    path.quadraticBezierTo(w * 0.5, h + 70, w, 200);
    path.lineTo(w, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
