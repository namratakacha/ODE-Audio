import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:music_player/screens/phone_number_screen.dart';
import 'package:music_player/screens/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late FocusNode pin2FocusNode;
  late FocusNode pin3FocusNode;
  late FocusNode pin4FocusNode;

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
    super.dispose();
  }

  void nextField({String? value, FocusNode? focusNode}) {
    if (value!.length == 1) {
      focusNode!.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 80,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context,
                MaterialPageRoute(builder: (context) => PhoneNumberScreen()));
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
          iconSize: 30,
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60, bottom: 20),
                child: Text(
                  'Verify Your Mobile',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  'Please, enter varification code we sent to your mobile',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Form(
                child: otpForm(),
              ),
              Timer(),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Resend Code?',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.lightBlue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    onPressed: () async {

                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setBool('phoneLoggedIn', true);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileScreen()));
                      print('phone login');
                    },
                    child: Text(
                      'Done',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row otpForm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 50,
          height: 60,
          child: TextFormField(
            autofocus: true,
            keyboardType: TextInputType.number,
            cursorColor: Colors.black,
            obscureText: true,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24),
            decoration: OtpInputDecoration(),
            onChanged: (value) {
              nextField(value: value, focusNode: pin2FocusNode);
            },
          ),
        ),
        SizedBox(width: 10),
        SizedBox(
          width: 50,
          height: 60,
          child: TextFormField(
            focusNode: pin2FocusNode,
            keyboardType: TextInputType.number,
            cursorColor: Colors.black,
            obscureText: true,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24),
            decoration: OtpInputDecoration(),
            onChanged: (value) {
              nextField(value: value, focusNode: pin3FocusNode);
            },
          ),
        ),
        SizedBox(width: 10),
        SizedBox(
          width: 50,
          height: 60,
          child: TextFormField(
            focusNode: pin3FocusNode,
            keyboardType: TextInputType.number,
            cursorColor: Colors.black,
            obscureText: true,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24),
            decoration: OtpInputDecoration(),
            onChanged: (value) {
              nextField(value: value, focusNode: pin4FocusNode);
            },
          ),
        ),
        SizedBox(width: 10),
        SizedBox(
          width: 50,
          height: 60,
          child: TextFormField(
            focusNode: pin4FocusNode,
            keyboardType: TextInputType.number,
            cursorColor: Colors.black,
            obscureText: true,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24),
            decoration: OtpInputDecoration(),
            onChanged: (value) {
              pin4FocusNode.unfocus();
            },
          ),
        ),
      ],
    );
  }

  InputDecoration OtpInputDecoration() {
    return InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        fillColor: Colors.blue[50],
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide.none));
  }
}

class Timer extends StatelessWidget {
  const Timer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, bottom: 10),
      child: TweenAnimationBuilder(
        duration: const Duration(seconds: 60),
        tween: Tween(begin: 60.0, end: 0),
        builder: (BuildContext context, dynamic value, Widget? child) {
          return Text(
            '00:${value.toInt()}',
            textAlign: TextAlign.center,
          );
        },
        onEnd: () {},
      ),
    );
  }
}
