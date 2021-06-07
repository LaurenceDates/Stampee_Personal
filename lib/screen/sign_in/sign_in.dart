import 'package:flutter/material.dart';
import 'package:stampee_personal/screen/sign_in/tab/email.dart';
import 'package:stampee_personal/screen/widget/custom_tab_view.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Stampee Personal"),
          ),
          body: Column(
            children: [
              Text('You are NOT signed in. Please SIGN IN or SIGN UP to start Application. '),
              Divider(),
              CustomTabView(
                  tabs: [
                    CustomTabItem(text: 'Email Sign IN'),
                    CustomTabItem(text: 'Email Sign UP'),
                  ],
                  contents: [
                    EmailSignInTab(),
                    EmailSignUpTab(),
                  ],
                  activeTabColor: Colors.green.shade400,
                  onActiveTab: Colors.white,
                  inactiveTabColor: Colors.lightGreen.shade100,
                  onInactiveTab: Colors.black,
                  contentBackgroundColor: Colors.lightGreen.shade100)
            ],
          )),
    );
  }
}
