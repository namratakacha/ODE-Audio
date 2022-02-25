import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:music_player/screens/login_screen.dart';
import 'package:music_player/models/walkthrough_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class walkThroughScreen extends StatefulWidget {
  const walkThroughScreen({Key? key}) : super(key: key);

  @override
  _walkThroughScreenState createState() => _walkThroughScreenState();
}

class _walkThroughScreenState extends State<walkThroughScreen> {
  int activeIndex = 0;
  bool displayGetStarted = false;
  var controller = CarouselController();

  @override
  void initState() {
    super.initState();
    setState(() {
      displayGetStarted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.white, Colors.white, Colors.lightBlue],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
            child: SafeArea(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 70),
                    child: SizedBox(
                      height: 80,
                      width: 160,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 100, right: 100),
                        child: Image.asset(
                          'assets/images/temp/page_logo.JPG',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      CarouselSlider.builder(
                        carouselController: controller,
                        itemCount: dataList.length,
                        itemBuilder: (context, index, realIndex) {
                          return carouselView(index);
                        },
                        options: CarouselOptions(
                          enableInfiniteScroll: false,
                          aspectRatio: 1,
                          autoPlay: false,
                          pageSnapping: false,
                          initialPage: 0,
                          enlargeCenterPage: false,
                          onPageChanged: (index, reason) {
                            setState(() {
                              activeIndex = index;
                              if (activeIndex == 2) {
                                setState(() {
                                  displayGetStarted = true;
                                });
                              } else {
                                setState(() {
                                  displayGetStarted = false;
                                });
                              }
                            });
                          },
                        ),
                      ),
                      AnimatedSmoothIndicator(
                        activeIndex: activeIndex,
                        count: dataList.length,
                        effect: SlideEffect(
                          dotColor: Colors.white,
                          activeDotColor: Colors.grey.shade800,
                          dotHeight: 10,
                          dotWidth: 10,
                        ),
                      ),
                      Container(
                        child: Stack(
                          children: [
                            Visibility(
                              visible:
                                  displayGetStarted == false ? true : false,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 100, left: 15, right: 15),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15),
                                        child: SizedBox(
                                          height: 50,
                                          child: OutlinedButton(
                                              style: OutlinedButton.styleFrom(
                                                  side: BorderSide(
                                                      color: Colors.white),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5))),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            LoginScreen()));
                                              },
                                              child: Text(
                                                'Skip',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        height: 50,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.grey[800],
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5))),
                                            onPressed: () {
                                              setState(() {
                                                controller.nextPage();
                                              });
                                            },
                                            child: Text(
                                              'Next',
                                              style:
                                                  TextStyle(color: Colors.white),
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                              visible:
                                  displayGetStarted != false ? true : false,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 100, left: 15, right: 15),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.grey[800],
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5))),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginScreen()));
                                      },
                                      child: Text(
                                        'Get started',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget carouselView(int index) {
    return carouselCard(dataList[index]);
  }

  Widget carouselCard(PreviewModel dataList) {
    var size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              height: height / 6,
              width: width / 1,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(dataList.imageName), fit: BoxFit.fill),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 5),
                        blurRadius: 8,
                        color: Colors.black38)
                  ]),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            dataList.title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: width * 0.05,
                color: Colors.lightBlue[800],
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
