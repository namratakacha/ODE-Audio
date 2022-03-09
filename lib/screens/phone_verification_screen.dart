import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:music_player/screens/dashboard_screen.dart';
import 'package:music_player/screens/otp_screen.dart';
import 'package:music_player/utils/screen_size.dart';
import 'package:http/http.dart' as http;

import '../models/login_model.dart';

class PhoneNumberScreen extends StatefulWidget {
  PhoneNumberScreen({Key? key}) : super(key: key);

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  TextEditingController phoneController = TextEditingController();
  String codeNumber = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isValidate = true;

  void _onCountryChange(CountryCode countryCode) {
    this.codeNumber = countryCode.toString();
    //print("New Country selected: " + countryCode.toString());
  }

  Future<void> login() async{
    if(phoneController.text.isNotEmpty){
      var response = await http.post(Uri.parse('https://php71.indianic.com/odemusicapp/public/api/v1/user/register'),
          body: ({
            "phone_number": phoneController.text,
            "dial_code": codeNumber,
          })
      );
      if(response.statusCode==200){
        String? token = "";
        token = LoginModel.fromJson(json.decode(response.body)).data?.token.toString();
        print("My token is - $token");
        Navigator.push(context, MaterialPageRoute(builder: (context)=>DashboardScreen()));
      } else{
        print(phoneController.text);
        print(codeNumber);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid credentials')));
      }
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Blank field not allowed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          color: Colors.white,
          child: Padding(
            // ignore: prefer_const_constructors
            padding: EdgeInsets.all(20),
            child: ListView(
              children: [
                SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 60),
                        child: SizedBox(
                          height: 180,
                          width: 160,
                          child: Image.asset(
                            'assets/images/temp/slash_logo.JPG',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Padding(
                        // ignore: prefer_const_constructors
                        padding: EdgeInsets.only(top: 50, bottom: 50),
                        child: Text(
                          'Verifiy Number',
                          style: TextStyle(
                              fontSize: screenWidth(context) * 0.07,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Mobile Number',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                              decoration: TextDecoration.none),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: CountryCodePicker(
                                  onChanged: _onCountryChange,
                                  initialSelection: 'CA',
                                  favorite: ['+1', 'CA'],
                                  showCountryOnly: false,
                                  showOnlyCountryWhenClosed: false,
                                  alignLeft: false,
                                  showDropDownButton: true,
                                  showFlag: false),
                            ),
                            Expanded(
                              flex: 2,
                              child: TextFormField(
                                controller: phoneController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter Mobile number';
                                  } else if (value.length < 10) {
                                    return 'Please enter valid mobile number';
                                  } else if (value.length > 10) {
                                    return 'Please enter valid mobile number';
                                  }
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: 'Enter Mobile Number',
                                  border: UnderlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.lightBlue,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5))),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  login();
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => DashboardScreen()));
                                }
                              },
                              // ignore: prefer_const_constructors
                              child: Text(
                                'Get OTP',
                                // ignore: prefer_const_constructors
                                style: TextStyle(fontSize: 16),
                              )),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
