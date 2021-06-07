import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:provider/provider.dart';
import 'package:stampee_personal/provider/data_provider.dart';
import 'package:stampee_personal/provider/signin_provider.dart';

import 'package:stampee_personal/component/user.dart';
import 'package:stampee_personal/component/stamp_book.dart';
import 'package:stampee_personal/screen/book_config/book_config.dart';
import 'package:stampee_personal/screen/new_book/new_book.dart';
import 'package:stampee_personal/screen/stamp_book/stamp_book.dart';
import 'package:stampee_personal/screen/splash/splash.dart';
import 'package:stampee_personal/screen/sign_in/sign_in.dart';

FirebaseAuth authInstance = FirebaseAuth.instance;
FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
AppUser appUserInstance = AppUser.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAuth.instance;
  runApp(GeneralProviders());
}

class GeneralProviders extends StatelessWidget {
  const GeneralProviders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<AppUser>(
            create: (context) => DataProvider.instance.stream, initialData: DataProvider.initialData),
        StreamProvider<User?>(
            create: (context) => SignInStateProvider.instance.stream, initialData: SignInStateProvider.initialData),
      ],
      child: AppHome(),
    );
  }
}

class AppHome extends StatelessWidget {
  AppHome({Key? key}) : super(key: key);
  // final FirebaseAnalytics analytics = FirebaseAnalytics();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green.shade600,
        canvasColor: Colors.lightBlue.shade50,
        accentColor: Colors.brown.shade600,
        dividerTheme: DividerThemeData(
          color: Colors.brown.shade600,
          space: 20.0,
          thickness: 1.5,
          indent: 10,
          endIndent: 10,
        ),
        cardTheme: CardTheme(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: Colors.lightGreen.shade100,
          margin: EdgeInsets.all(10),
          shadowColor: Colors.black,
          elevation: 10,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.green.shade400, width: 3.0),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.all(3)),
          foregroundColor: MaterialStateProperty.all(Colors.brown.shade600),
        )),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.all(10)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
            side: MaterialStateProperty.all(BorderSide(color: Colors.brown.shade600, width: 3)),
            textStyle: MaterialStateProperty.all(TextStyle(fontWeight: FontWeight.bold)),
            foregroundColor: MaterialStateProperty.all(Colors.brown.shade600),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.all(10)),
            backgroundColor: MaterialStateProperty.all(Colors.brown.shade500),
          ),
        ),
      ),
      // navigatorObservers: [
      //   FirebaseAnalyticsObserver(analytics: analytics),
      // ],
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/SignInScreen': (context) => SignInScreen(),
        '/StampBookScreen': (context) => StampBookScreen(),
        '/NewBookScreen': (context) => NewBookScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/BookConfigScreen') {
          final bookData = settings.arguments as StampBook;
          return MaterialPageRoute(
            builder: (context) => BookConfigScreen(bookData: bookData),
          );
        }
      },
    );
  }
}
