import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:music_player/Pages/account.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:music_player/models/profile_update_model.dart';
import 'package:music_player/screens/bottom_navigation.dart';
import 'package:music_player/screens/dashboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class EditAccount extends StatefulWidget {
  String? name;
  String? email;
  String? phone;
  String? img;

  EditAccount({Key? myKey, this.name, this.email, this.phone, this.img})
      : super(key: myKey);

  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _selectedGender = '';
  final user = FirebaseAuth.instance.currentUser;
  File? pickedImage;
  String? name;

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
      },
    );
  }

  Future addProfileUpdate() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token") ?? "";


    var url = Uri.parse(
      'https://php71.indianic.com/odemusicapp/public/api/v1/user/update',
    );


    http.MultipartRequest request = http.MultipartRequest("POST", url);

    if (pickedImage != null) {
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
        'profile_image',
        pickedImage!.path,
        contentType: MediaType("image", "${pickedImage!
            .path
            .split(".")
            .last}"),
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

        var name = ProfileUpdateModel
            .fromJson(json.decode(res.body))
            .data
            ?.name
            .toString();
        var email = ProfileUpdateModel
            .fromJson(json.decode(res.body))
            .data
            ?.email
            .toString();
        var phone = ProfileUpdateModel
            .fromJson(json.decode(res.body))
            .data
            ?.phoneNumber
            .toString();
        var img = ProfileUpdateModel
            .fromJson(json.decode(res.body))
            .data
            ?.profileimageUrl
            .toString();
        var _selectedGender = ProfileUpdateModel
            .fromJson(json.decode(res.body))
            .data
            ?.gender
            .toString();

        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString("name", name!);
        preferences.setString("email", email!);
        preferences.setString("phone_number", phone!);
        preferences.setString("profileimage_url", img!);
        preferences.setString('gender', _selectedGender!);

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LibraryScreen(selectedIndex: 3,)));
          //  MaterialPageRoute(builder: (context) => MyAccountPage(context)));

        setState(() {});
      } else {
        print(response.statusCode);
        print('No data');
      }
      setState(() {});
    }
    else {
      final userData = jsonEncode({
        "name": nameController.text,
        "email": emailController.text,
        "gender": _selectedGender,
        "phone_number": phoneController.text,
      });
      final response = await http.post(url,
          body: userData,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      if (response.statusCode == 200) {
        print(response.statusCode);
        print(response.body);
        var name = ProfileUpdateModel
            .fromJson(json.decode(response.body))
            .data
            ?.name
            .toString();
        var email = ProfileUpdateModel
            .fromJson(json.decode(response.body))
            .data
            ?.email
            .toString();
        var phone = ProfileUpdateModel
            .fromJson(json.decode(response.body))
            .data
            ?.phoneNumber
            .toString();
        var _selectedGender = ProfileUpdateModel
            .fromJson(json.decode(response.body))
            .data
            ?.gender
            .toString();

        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString("name", name!);
        preferences.setString("email", email!);
        preferences.setString("phone_number", phone!);
        preferences.setString('gender', _selectedGender!);


        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LibraryScreen(selectedIndex: 3,)));

        // Navigator.of(context, rootNavigator: false).push(MaterialPageRoute<bool>(fullscreenDialog: false,
        //     builder: (context) => MyAccountPage(), maintainState: false));

        setState(() {});
      } else {
        print(response.statusCode);
        print('No data');
      }

    }

  }

  @override
  void initState() {
    super.initState();
    setGender();
    nameController = TextEditingController(text: widget.name);
    emailController = TextEditingController(text: widget.email);
    phoneController = TextEditingController(text: widget.phone);
  }

  setGender() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedGender = prefs.getString('gender') ?? "";
      print(_selectedGender);
    });
  }
  Future<bool> _onWillPop() async {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LibraryScreen(selectedIndex: 3,)));
      return true;
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'EDIT MY ACCOUNT',
            style: TextStyle(
                fontSize: 24,
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
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LibraryScreen(selectedIndex: 3,)));
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
        body: Form(
          key: _formKey,
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 25, 20, 20),
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          _showChoiceDialog(context);
                        },
                        child: (pickedImage != null)
                            ? CircleAvatar(
                                radius: 50,
                                foregroundImage:
                                    FileImage(File(pickedImage!.path)),
                                backgroundImage: AssetImage(
                                    'assets/images/temp/profile_pic_camera.PNG'),
                              )
                            : CircleAvatar(
                                radius: 50,
                                foregroundImage: NetworkImage(
                                    user?.photoURL ?? widget.img ?? ''),
                                backgroundImage: AssetImage(widget.img ??
                                    'assets/images/temp/profile_pic_camera.PNG'),
                              ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text('Full Name'),
                  ),
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
                    padding: const EdgeInsets.only(top: 25),
                    child: Text('Email Address'),
                  ),
                  TextFormField(
                    controller: emailController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter email';
                      }
                    },
                    decoration:
                        InputDecoration(hintText: 'Enter your email address'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Text('Mobile Number'),
                  ),
                  TextFormField(
                    controller: phoneController,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Enter Mobile Number',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Text('Gender'),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          leading: Radio<String>(
                            value: 'Male',
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
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.lightBlue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5))),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString('gender', _selectedGender);

                                addProfileUpdate();


                            }

                          },
                          child: Text(
                            'Save Changes',
                            style: TextStyle(fontSize: 16),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _openGallery(BuildContext context) async {
    var pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        pickedImage = File(pickedFile.path);
        Navigator.pop(context);
      });
    }
  }

  void _openCamera(BuildContext context) async {
    var pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        pickedImage = File(pickedFile.path);
        Navigator.pop(context);
      });
    }
  }
}
