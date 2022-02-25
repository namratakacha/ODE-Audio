import 'package:flutter/material.dart';
import 'package:music_player/screens/dashboard_screen.dart';
import 'package:music_player/screens/profile_screen.dart';

class TermsAndConditionScreen extends StatefulWidget {
  const TermsAndConditionScreen({Key? key}) : super(key: key);

  @override
  _TermsAndConditionScreenState createState() =>
      _TermsAndConditionScreenState();
}

class _TermsAndConditionScreenState extends State<TermsAndConditionScreen> {
  bool agree = false;

  // void _enableButton() {
  //   setState(() {
  //     agree = true;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var _onPressed;
    if (agree) {
      _onPressed = () {
        return Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => DashboardScreen()));
      };
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 80,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()));
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
          iconSize: 30,
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
          child: ListView(
            children: [
              Text(
                'Terms & Conditions',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Text(
                "\nContrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of 'de Finibus Bonorum et Malorum' (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, 'Lorem ipsum dolor sit amet..', comes from a line in section 1.10.32. \n\nThe standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from 'de Finibus Bonorum et Malorum' by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.",
                style: TextStyle(fontSize: 16, color: Colors.grey[800]),
              ),
              Row(
                children: [
                  Transform.scale(
                    scale: 1.3,
                    child: Checkbox(
                      value: agree,
                      shape: CircleBorder(),
                      onChanged: (value) {
                        setState(
                          () {
                            agree = value ?? false;
                          },
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Text.rich(
                        TextSpan(
                          text: 'I accept the',
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[800]),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Terms of Service',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[800],
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            TextSpan(
                              text: ' and ',
                              style: TextStyle(
                                  fontSize: 18, color: Colors.grey[800]),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Privacy Policy',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[800],
                                      decoration: TextDecoration.underline),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        onSurface: Colors.blue[900],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    onPressed: _onPressed,
                    // if (agree) {
                    //   return _enableButton();
                    // } else if (agree) {
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => DashboardScreen()));
                    // } else {
                    //   return null;
                    // }

                    // agree ? () => _enableButton() : null,
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => loginScreen()));

                    child: Text(
                      'Done',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
