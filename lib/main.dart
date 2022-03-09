import 'package:flutter/material.dart';
import 'package:music_player/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:music_player/utils/google_sign_in.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
  final _navigatorKey = GlobalKey();

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
          title: 'ODE Audio',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Splash(),

      ),

    );
  }
}
