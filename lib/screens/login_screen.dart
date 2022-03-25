import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_player/models/social_login_model.dart';
import 'package:music_player/screens/dashboard_screen.dart';
import 'package:music_player/screens/phone_number_screen.dart';
import 'package:music_player/utils/google_sign_in.dart';
import 'package:music_player/utils/screen_size.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';


class LoginScreen extends StatefulWidget {
   LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var googleId;
  var email;

  Future<void> socialLogin() async{
    final user = FirebaseAuth.instance.currentUser;

      var response = await http.post(Uri.parse('https://php71.indianic.com/odemusicapp/public/api/v1/user/sociallogin'),
          body: ({
            "google_id": user?.uid,
            "email": user?.email,
          })
      );
      if(response.statusCode==200){
        String? token = "";
        token = SocialLogin.fromJson(json.decode(response.body)).data?.token.toString();
        print("My token is - $token");
        print('API call success');
        print(user?.uid);
        print(user?.email);
        setToken(token.toString());
       Navigator.push(context, MaterialPageRoute(builder: (context)=>DashboardScreen()));
      } else{
        print(googleId);
        print(email);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid credentials')));
      }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 140),
                    child: SizedBox(
                      height: 160,
                      width: 140,
                      child: Image.asset(
                        'assets/images/temp/slash_logo.JPG',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: button(
                      color: Colors.lightBlue,
                      title: 'Phone Number',
                      onpressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PhoneNumberScreen()));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.grey,
                            height: 1,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text('Or Continue With',
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                                decoration: TextDecoration.none,
                                letterSpacing: 0,
                                wordSpacing: 0)),
                        SizedBox(width: 8),
                        Expanded(
                          child: Divider(
                            color: Colors.grey,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: button(
                        onpressed: () {},
                        color: Colors.indigo[400],
                        title: 'Sign In With Facebook'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: button(
                        onpressed: () async {
                          final provider = Provider.of<GoogleSignInProvider>(
                              context,
                              listen: false);
                          provider.googleLogin().then((value) =>
                          socialLogin());
                          print('googlelogin');
                        },
                        color: Colors.blue[400],
                        title: 'Sign In With google'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> setToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("token", token);
  }
}

class button extends StatelessWidget {
  final color;
  final title;
  final onpressed;

  const button(
      {Key? key,
      required this.color,
      required this.title,
      required this.onpressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: color,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5))),
          onPressed: () {
            onpressed();
          },
          child: Text(
            title,
            style: TextStyle(
                color: Colors.white, fontSize: screenWidth(context) * 0.04),
          )),
    );
  }
}

