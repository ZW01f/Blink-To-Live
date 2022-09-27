import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shared/data.dart';
import 'package:carousel_slider/carousel_slider.dart';

class TeachPatientScreen extends StatefulWidget {
  const TeachPatientScreen({Key? key}) : super(key: key);

  @override
  State<TeachPatientScreen> createState() => _TeachPatientScreenState();
}

class _TeachPatientScreenState extends State<TeachPatientScreen> {
  bool _show = false;
  var formKey = GlobalKey<FormState>();
  int? sec;
  int? min;
  int? hor;
  int sec2 = 0;
  int min2 = 0;
  int hor2 = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Container(
                    child: CarouselSlider(
                      items: blinkToSpeakBook
                          .map((item) => Container(
                                child: Image.asset(
                                  'assets/$item',
                                  fit: BoxFit.fill,
                                ),
                              ))
                          .toList(),
                      options: CarouselOptions(
                        height: 550,
                        autoPlay: true,
                        autoPlayInterval:
                            Duration(seconds: sec2, minutes: min2, hours: hor2),
                        enlargeCenterPage: true,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              _show = true;
              setState(() {});
            },
            child: Icon(Icons.timer)),
        bottomSheet: _showBottomSheet(),
      ),
    );
  }

  Widget? _showBottomSheet() {
    if (_show) {
      return BottomSheet(
        onClosing: () {},
        builder: (context) {
          return Stack(
            children: [
              Container(
                height: 120,
                width: double.infinity,
                color: Colors.grey.shade200,
                alignment: Alignment.center,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 60.0, right: 120, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'null';
                            }
                          },
                          onChanged: (value) {
                            sec = int.parse(value);
                          },
                          decoration: InputDecoration(
                              labelText: 'sec',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5))),
                        ),
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'null';
                            }
                          },
                          onChanged: (value) {
                            min = int.parse(value);
                          },
                          decoration: InputDecoration(
                              labelText: 'min',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5))),
                        ),
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            hor = int.parse(value);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'null';
                            }
                          },
                          decoration: InputDecoration(
                              labelText: 'hou',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5))),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 18.0, right: 80),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          _show = false;
                          setState(() {});
                        },
                        icon: Icon(
                          Icons.close,
                          size: 20,
                        )),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            sec2 = sec!;
                            min2 = min!;
                            hor2 = hor!;
                            print('$sec2  $min2   $hor2');
                          });
                          _show = false;
                        },
                        icon: Icon(
                          Icons.done,
                          size: 20,
                        )),
                  ],
                ),
              ),
            ],
          );
        },
      );
    } else {
      return null;
    }
  }
}
