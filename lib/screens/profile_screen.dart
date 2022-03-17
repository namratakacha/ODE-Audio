import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:music_player/models/profile_update_model.dart';
import 'package:music_player/screens/dashboard_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';

class ProfileScreen extends StatefulWidget {
  String? phone;
  String? code;

  ProfileScreen({Key? key, this.phone, this.code}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String codeNumber = "";
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _selectedGender = 'male';
  File? pickedImage;

  Future addProfileUpdate() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token") ?? "";


    var url = Uri.parse(
      'https://php71.indianic.com/odemusicapp/public/api/v1/user/update',
    );
    http.MultipartRequest request = http.MultipartRequest("POST", url);

    http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
      'profile_image',
      pickedImage!.path,
      contentType: MediaType("image", "${pickedImage!.path.split(".").last}"),
    );

    File(pickedImage!.path).exists().then((value) => print(value));

    request.headers['Authorization'] = 'Bearer $token';
    request.headers['Content-Type'] = 'multipart/form-data';
    request.fields["name"] = nameController.text;
    request.fields["email"] = emailController.text;
    request.fields["gender"] = _selectedGender;
    request.fields["phone_number"] = phoneController.text;
    request.files.add(multipartFile);

    var response = await request.send();

    if (response.statusCode == 200) {
      print(response.statusCode);

      final res = await http.Response.fromStream(response);
      print(res.body);

      var name = ProfileUpdateModel.fromJson(json.decode(res.body))
          .data
          ?.name
          .toString();
      var email = ProfileUpdateModel.fromJson(json.decode(res.body))
          .data
          ?.email
          .toString();
      var phone = ProfileUpdateModel.fromJson(json.decode(res.body))
          .data
          ?.phoneNumber
          .toString();
      var img = ProfileUpdateModel.fromJson(json.decode(res.body))
          .data
          ?.profileimageUrl
          .toString();
      var _selectedGender = ProfileUpdateModel.fromJson(json.decode(res.body))
          .data
          ?.gender.toString();

      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("name", name!);
      preferences.setString("email", email!);
      preferences.setString("phone_number", phone!);
      preferences.setString("profileimage_url", img!);
     // preferenc('gender', _selectedGender!);

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => DashboardScreen()));

      setState(() {});
    } else {
      print(response.statusCode);
      print('No data');
    }
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Choose option",
              style: TextStyle(color: Colors.blue),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _openGallery(context);
                    },
                    title: Text("Gallery"),
                    leading: Icon(
                      Icons.account_box,
                      color: Colors.blue,
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _openCamera(context);
                    },
                    title: Text("Camera"),
                    leading: Icon(
                      Icons.camera,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _onCountryChange(CountryCode countryCode) {
    this.codeNumber = countryCode.toString();
    //print("New Country selected: " + countryCode.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(15),
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
                              fit: BoxFit.fill),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30, bottom: 30),
                        child: Text(
                          'Complete your Profile',
                          style: TextStyle(
                              fontSize: 28,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none),
                        ),
                      ),
                      InkWell(
                        child: Container(
                          height: 120,
                          width: 120,
                          child: (pickedImage != null)
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    pickedImage!,
                                    fit: BoxFit.fill,
                                  ))
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                      'assets/images/temp/profile_pic_camera.PNG',
                                      fit: BoxFit.fill),
                                ),
                        ),
                        onTap: () {
                          _showChoiceDialog(context);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text('Full Name'),
                TextFormField(
                  controller: nameController,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name';
                    }
                  },
                  decoration: InputDecoration(hintText: 'Enter your name'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: CountryCodePicker(
                            initialSelection: 'CA',
                            onChanged: _onCountryChange,
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
                          textInputAction: TextInputAction.next,
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
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text('Email Address'),
                TextFormField(
                  controller: emailController,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Email';
                    }
                  },
                  decoration: InputDecoration(hintText: 'Enter email address'),
                ),
                SizedBox(height: 20),
                Text('Gender'),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        leading: Radio<String>(
                          value: 'male',
                          groupValue: _selectedGender,
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value!;
                            });
                          },
                        ),
                        title: const Text('Male'),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        leading: Radio<String>(
                          value: 'Female',
                          groupValue: _selectedGender,
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value!;
                            });
                          },
                        ),
                        title: const Text('Female'),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: SizedBox(
                          height: 50,
                          child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  side: BorderSide(color: Colors.lightBlue),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5))),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DashboardScreen()));
                              },
                              child: Text(
                                'Skip',
                                style: TextStyle(color: Colors.lightBlue),
                              )),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.lightBlue,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                addProfileUpdate();
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             MyAccountPage(name: nameController.text,phone: phoneController.text,email: emailController.text,img: pickedImage?.path.toString())));

                              }
                            },
                            child: Text('Done')),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile == null) return;
    final imageTemporary = File(pickedFile.path);

    setState(() {
      this.pickedImage = imageTemporary;
      print(pickedImage);
    });

    Navigator.pop(context);
  }

  void _openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile == null) return;
    final imageTemporary = File(pickedFile.path);

    setState(() {
      this.pickedImage = imageTemporary;
      print(pickedImage);
    });
    Navigator.pop(context);
  }
}
