import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:music_player/screens/dashboard_screen.dart';
import 'package:music_player/screens/login_screen.dart';
import 'package:music_player/utils/google_sign_in.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          final provider =
              Provider.of<GoogleSignInProvider>(context, listen: false);
          if (provider.isSigningIn) {
            print('loading...');
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return LoginScreen();
          } else if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          } else {
            return DashboardScreen();
          }
        },
      ),
    );
  }
}
