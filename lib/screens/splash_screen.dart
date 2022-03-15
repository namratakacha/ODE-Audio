import 'dart:async';

import 'package:flutter/material.dart';

import 'package:music_player/screens/dashboard_screen.dart';
import 'package:music_player/walkthrough_page.dart';
import 'package:music_player/utils/screen_size.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5));
    checkLogin();
    super.initState();
  }

  checkLogin() async {
    Future.delayed(const Duration(seconds: 10));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";
    bool? phoneLoggedIn = prefs.getBool('phoneLoggedIn');



    if (phoneLoggedIn ?? false) {

      if(!token.isEmpty){
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => DashboardScreen()));
        print('mobile');
      }else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => walkThroughScreen()));
      }

    } else if (!token.isEmpty) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => DashboardScreen()));
        print('google');

    } else {
      print('no login');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => walkThroughScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.white, Colors.white, Colors.lightBlue],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 450),
          child: SizedBox(
              height: 200,
              width: 170,
              child: Image.asset(
                'assets/images/temp/slash_logo.JPG',
                fit: BoxFit.fill,
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            'Powered by Lowekey',
            style: TextStyle(
                fontSize: screenWidth(context) * 0.03,
                color: Colors.black38,
                decoration: TextDecoration.none),
          ),
        )
      ],
    );
  }
}
