import 'package:flutter/material.dart';
import 'package:music_player/Pages/account.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  TextEditingController nameController = TextEditingController();
  TextEditingController msgController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CONTACT US',
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
            Navigator.pop(context,
                MaterialPageRoute(builder: (context) => MyAccountPage()));
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
            padding: const EdgeInsets.all(15),
            child: ListView(
              children: [
                SizedBox(
                  height: 210,
                  width: 270,
                  child: Image.asset(
                    'assets/images/temp/contact_us_img.JPG',
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text('Name'),
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
                  child: Text('Your Message'),
                ),
                TextFormField(
                  controller: emailController,
                  textInputAction: TextInputAction.done,
                  maxLines: 5,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter message';
                    }
                  },
                  decoration: InputDecoration(hintText: 'Your message here...'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.lightBlue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5))),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {}
                        },
                        child: Text(
                          'Send',
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
}
