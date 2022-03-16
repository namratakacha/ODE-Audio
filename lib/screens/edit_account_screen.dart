import 'dart:io';


import 'package:flutter/material.dart';
import 'package:music_player/Pages/account.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

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
  String _selectedGender = 'Female';
  final user = FirebaseAuth.instance.currentUser;
  File? pickedImage;

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
        },);
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    emailController = TextEditingController(text: widget.email);
    phoneController = TextEditingController(text: widget.phone);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
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
            Navigator.pop(
                context,
                MaterialPageRoute(
                    builder: (context) => MyAccountPage(
                        name: nameController.text,
                        email: emailController.text,
                        phone: phoneController.text,
                        img: pickedImage!.path,
                    )));
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
                      onTap: (){
                        _showChoiceDialog(context);
                      },
                      child: (pickedImage != null)?
                      CircleAvatar(
                        radius: 50,
                        foregroundImage: FileImage(File(pickedImage!.path)),
                        backgroundImage:
                        AssetImage('assets/images/temp/profile_pic_camera.PNG'),
                      )
                          :CircleAvatar(
                        radius: 50,
                        foregroundImage: NetworkImage(user?.photoURL ?? widget.img ?? ''),
                        backgroundImage:
                        AssetImage('assets/images/temp/profile_pic_camera.PNG'),
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
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.pop(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyAccountPage(
                                          name: nameController.text,
                                          email: emailController.text,
                                          phone: phoneController.text,
                                          img: pickedImage!.path,
                                        )));
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
    );
  }
  void _openGallery(BuildContext context) async {
    final XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile == null) return;
    final imageTemporary = File(pickedFile.path);

    setState(() {
      this.pickedImage = imageTemporary;
    });

    Navigator.pop(context);
  }

  void _openCamera(BuildContext context) async {
    final XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile == null) return;
    final imageTemporary = File(pickedFile.path);

    setState(() {
      this.pickedImage = imageTemporary;
    });
    Navigator.pop(context);
  }
}
