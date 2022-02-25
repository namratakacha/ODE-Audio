

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:launch_review/launch_review.dart';

class RateTheApp extends StatefulWidget {
  const RateTheApp({Key? key}) : super(key: key);

  @override
  _RateTheAppState createState() => _RateTheAppState();
}

class _RateTheAppState extends State<RateTheApp> {
  double? _ratingValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'RATE THE APP',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.lightBlue),
          ),
          toolbarHeight: 70,
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 2,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Padding(
              padding: const EdgeInsets.only(left: 11),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 30,
              ),
            ),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  SizedBox(
                    height: 220,
                    width: 400,
                    child: Image.asset(
                      'assets/images/temp/rate_app.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(height: 25),
                  // implement the rating bar
                  RatingBar(
                      initialRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      ratingWidget: RatingWidget(
                          full: const Icon(Icons.star, color: Colors.orange),
                          half: const Icon(
                            Icons.star_half,
                            color: Colors.orange,
                          ),
                          empty: const Icon(
                            Icons.star_outline,
                            color: Colors.orange,
                          )),
                      onRatingUpdate: (value) {
                        setState(() {
                          _ratingValue = value;
                        });
                      }),
                  const SizedBox(height: 25),
                  // Display the rate in number
                  Container(
                    width: 80,
                    height: 30,
                    decoration: const BoxDecoration(
                        color: Colors.lightBlue, shape: BoxShape.rectangle),
                    alignment: Alignment.center,
                    child: Text(
                      _ratingValue != null ? _ratingValue.toString() : 'Rate it!',
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 35),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40),
                    child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.lightBlue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5))),
                          onPressed: () {
                            LaunchReview.launch(androidAppId: "com.facebook.katana",
                                iOSAppId: "284882215");
                          },
                          child: Text('Rate Now',style: TextStyle(fontSize: 16),),
                        )),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40),
                    child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              primary: Colors.white,
                              side: BorderSide(color: Colors.lightBlue),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5))),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Maybe Later',
                            style: TextStyle(color: Colors.lightBlue, fontSize: 16),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
