
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:music_player/screens/contact_us_screen.dart';
import 'package:music_player/screens/edit_account_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:music_player/screens/login_screen.dart';
import 'package:music_player/screens/rating_screen.dart';
import 'package:music_player/utils/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MyAccountPage extends StatefulWidget {
  String? name;
  String? email;
  String? phone;
  String? img;
  String? gender;

  MyAccountPage({Key? myKey, this.name, this.email, this.phone, this.img, this.gender})
      : super(key: myKey);

  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  bool isSwitched = false;
  String? name;
  String? email;
  String? phone;
  String? img;



  @override
  void initState()  {
    loadUserData();
    super.initState();
  }

  loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name');
      print(name);
      email = prefs.getString('email');
      print(email);
      phone = prefs.getString('phone_number');
      print(phone);
      img = prefs.getString('profileimage_url');
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MY ACCOUNT',
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text("Are you sure you want to logout?"),
                    actions: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: Text("No"),
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            if (prefs.containsKey('phoneLoggedIn')) {
                              print('phone logout');
                              await prefs.clear().then((value) =>
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()),
                                          (route) => false));

                            } else {
                              final provider =
                                  Provider.of<GoogleSignInProvider>(context,
                                      listen: false);
                              provider.logout().then((value) => prefs
                                  .clear()
                                  .then((value) => Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()),
                                      (route) => false)));
                              print('google logout');
                            }
                          },
                          child: Text('Yes'))
                    ],
                  ),
                );
              },
              icon: Icon(
                Icons.logout_rounded,
                color: Colors.lightBlue,
                size: 40,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(21),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 18),
                    child: InkWell(
                      onTap: (){

                      },
                      child: CircleAvatar(
                        radius: 50,
                        foregroundImage: NetworkImage(user?.photoURL ?? img ?? widget.img ?? ''),
                        backgroundImage:
                        AssetImage( widget.img ?? 'assets/images/temp/profile_pic_camera.PNG'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 35),
                    child: Container(
                      height: 145,
                      width: 75,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditAccount(
                                          name: name ?? widget.name ??
                                              user?.displayName ??
                                              '',
                                          email: email ?? widget.email ??
                                              user?.email ??
                                              '',
                                          phone: phone ?? widget.phone ??
                                              user?.phoneNumber ??
                                              '',
                                          img: img ?? widget.img ??
                                              user?.photoURL ??
                                              'assets/images/temp/profile_pic_camera.PNG',
                                        )));
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.lightBlue,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Text(
                name??
                    widget.name ??
                user?.displayName ?? '',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text(
                email??
                    widget.email ??
                user?.email ?? '',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                textAlign: TextAlign.center,
              ),
              Text(
                phone??
                    widget.phone ?? '',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  height: 75,
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.lightBlue, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                          setState(
                            () {
                              isSwitched = !isSwitched;
                            },
                          );
                        },
                        child: ListTile(
                          title: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text(
                              'Push Notification',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          trailing: Transform.scale(
                            scale: 0.6,
                            child: CupertinoSwitch(
                              value: isSwitched,
                              activeColor: Colors.lightBlue,
                              onChanged: (value) {
                                setState(
                                  () {
                                    isSwitched = value;
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  height: 75,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ContactUs()));
                    },
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.lightBlue, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: ListTile(
                          title: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text(
                              'Contact Us',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ContactUs()));
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              size: 25,
                              color: Colors.lightBlue,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  height: 75,
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.lightBlue, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>RateTheApp()));
                        },
                        child: ListTile(
                          title: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text(
                              'Rate the app',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>RateTheApp()));
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              size: 25,
                              color: Colors.lightBlue,
                            ),
                          ),
                        ),
                      ),
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

}
