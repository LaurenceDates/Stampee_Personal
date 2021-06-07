import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:stampee_personal/component/startup.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      User? user = Provider.of<User?>(context, listen: false);
      switch (user) {
        case null:
          Navigator.pushReplacementNamed(context, '/SignInScreen');
          break;
        default:
          initializeFunction(user!);
      }
    });
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('asset/image/logo192.webp'),
        SizedBox(height: 10),
        CircularProgressIndicator(),
      ],
    );
  }

  void initializeFunction(User user) async {
    await StartUpFunction.onSplash(user.uid);
    Navigator.pushReplacementNamed(context, '/StampBookScreen');
    print('pushed');
  }
}
